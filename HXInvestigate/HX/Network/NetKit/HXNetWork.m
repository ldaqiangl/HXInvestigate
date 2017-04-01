//
//  HXNetWork.m
//  AFNetworking Example
//
//  Created by 董富强 on 16/7/12.
//
//

#import "HXNetWork.h"
#import "MBProgressHUD.h"

@implementation HXNetWork

+ (HXNetWork *)shareInstance{
    static dispatch_once_t onceToken;
    static HXNetWork * __HXNetWork__;
    dispatch_once(&onceToken, ^{
        __HXNetWork__=[[[self class] alloc] init];
    });
    return __HXNetWork__;
}


- (instancetype)init{
    
    if (self=[super init]) {
        _cacheHeaderDictionary=[[NSMutableDictionary alloc] init];
        NSDictionary *tempHeader=[self getHeader];
        
        if (tempHeader) {
            [_cacheHeaderDictionary addEntriesFromDictionary:tempHeader];
        }
    }
    return self;
    
}


- (NSDictionary *)getHeader {
    
    NSDictionary *info=[[NSBundle mainBundle] infoDictionary];
    
    HXAPP *app=[[HXAPP alloc] init];
    
    app.PackageName=info[@"CFBundleIdentifier"];
    NSString *appName=info[@"CFBundleDisplayName"];
    if (!appName) {
        appName=info[@"CFBundleName"];
    }
    app.AppName=appName;
    app.Version=info[@"CFBundleShortVersionString"];
    app.MobileType=@"iOS";
    app.Channel=@"1";
    
    HXDevice *device=[[HXDevice alloc] init];
    device.Platform=@"iOS";
    device.Model=@"1";
    device.Factory=@"Apple";
    device.ScreenSize=NSStringFromCGSize([[UIScreen mainScreen] currentMode].size);
    device.Denstiy=@"1";
    device.IMEI=@"123";
    device.Mac=@"00:00:00:00:00:00";
    device.ClientId=[[UIDevice currentDevice] udidString_Ext];
    
    
    HXHeader *header=[[HXHeader alloc] init];
    header.Device=device;
    header.App=app;
    
    return [MTLJSONAdapter JSONDictionaryFromModel:header];
}

- (id)getEffectiveObject:(id)obj {
    if (obj==nil) {
        return [NSNull null];
    } else {
        return obj;
    }
}


- (NSData *)getJSONDataWithDicationary:(NSDictionary *)dictionary {
    
    //    if (![NSJSONSerialization isValidJSONObject:self]) {
    //        return nil;
    //    }
    NSError * error=nil;
    NSData * data=nil;
    NSException * exce=nil;
    @try {
        ///这里的options参数为kNilOptions,转换为json的时候不添加\n格式化换行
        ///当该参数为NSJSONWritingPrettyPrinted时，添加\n格式化换行，方便阅读
        data= [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    }
    @catch (NSException *exception) {
        exce=exception;
    }
    @finally {
        
    }
    
    if (error || exce) {
        NSLog(@"%@",exce);
        return nil;
    }
    
    return data;
    
}

- (NSString *)getJSONStringWithDicationary:(NSDictionary *)dicationary {
    
    NSData * data=[self getJSONDataWithDicationary:dicationary];
    if (data) {
        __autoreleasing NSString *  string=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return string;
    }
    return nil;
}


- (id)objectFromJSONData:(NSData *)jsonData {
    
    if (self==nil) {
        return nil;
    }
    
    id obj=nil;
    NSError * error=nil;
    NSException * excp=nil;
    @try {
        obj=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    }
    @catch (NSException *exception) {
        excp=exception;
    }
    @finally {
        
    }
    
    if (error||excp) {
        NSLog(@"%@",[excp description]);
        return nil;
    }
    
    return obj;
    
}


- (id)objectFromJSONString:(NSString *)jsonString {
    NSData * data=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [self objectFromJSONData:data];
}




- (NSMutableURLRequest *)getURLRequestWithURL:(NSURL *)url header:(NSDictionary *)header {
    NSMutableURLRequest * urlrequest=[NSMutableURLRequest requestWithURL:url];
    [urlrequest setHTTPMethod:@"POST"];
    
    for (NSString * key in [header allKeys])
    {
        [urlrequest addValue:[header objectForKey:key] forHTTPHeaderField:key];
    }
    
    //    ///multipart/form-data
    //    [urlrequest setValue:[NSString stringWithFormat:@"multipart/form-data;"] forHTTPHeaderField:@"Content-Type"];
    
    return urlrequest;
}


- (NSData *)getBodyStringFromParameters:(NSDictionary *)parmenters encoden:(NSStringEncoding)en {
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic addEntriesFromDictionary:parmenters];
    
    if (self.cacheHeaderDictionary) {
        [dic setObject:[self getEffectiveObject:self.cacheHeaderDictionary] forKey:@"Header"];
    }
    
    NSString *jsonstring = [self getJSONStringWithDicationary:dic];
    
#if kHXEnableLog
    NSLog(@"请求数据:%@",jsonstring);
#endif
    return [jsonstring dataUsingEncoding:en];
}


- (MBProgressHUD *)getMBProgressHUDwithLoadString:(NSString *)loadString detailString:(NSString *)detailString isShowCancel:(BOOL)isShowCancel cancelBlock:(MBProgressHUDCancelBlock)cancelBalock {
    
    UIWindow *kWindow=[[[UIApplication sharedApplication] delegate] window];
    
    __block MBProgressHUD * hud=[[MBProgressHUD alloc] initWithView:kWindow];
    hud.labelText=loadString;
    hud.detailsLabelText=detailString;
    hud.mode=MBProgressHUDModeIndeterminate;
    hud.animationType=MBProgressHUDAnimationFade;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [kWindow  addSubview:hud];
        [hud show:YES];
    });
    
    
    return hud;
}



- (NSURLSessionTask *)startRequestTaskWithBodyData:(NSData *)data
                                               url:(NSURL *)url
                                        httpHeader:(NSDictionary *)hedader
                                   completionBlock:(void (^)(NSURLSessionTask *operation, id responseObject,NSError *error))comblock
                               uploadProgressBlock:(void (^)(NSURLSessionTask *operation,NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))uploadprogressBlock
                             downloadProgressBlock:(void (^)(NSURLSessionTask *operation,NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))downloadProgressBlock
                                         animation:(BOOL)isAnimation
                                              info:(NSDictionary *)info
                                   timeoutInterval:(NSTimeInterval)timeoutInterval {
    
    ///url请求地址
    __autoreleasing NSMutableURLRequest * request = [self getURLRequestWithURL:url header:hedader];
    if (timeoutInterval>0) {
        [request setTimeoutInterval:timeoutInterval];
    }
    [request setHTTPBody:data];
    
    //创建Task 使用AFN去执行 网络请求
    
    
    return nil;
}



- (HXNetworkResult *)getNetworkResultWithData:(NSData *)resopnseData requestCode:(NSString *)requestCode withBusinessLogicBlock:(NSArray* (^)(id dataObject))dblock {
    
    __autoreleasing HXNetworkResult * netResult=[[HXNetworkResult alloc] init];
    
    netResult.data=resopnseData;
    
    // __autoreleasing NSString * dataString=[[NSString alloc] initWithData:operation.responseData encoding:-2147482062];//
    
    if (resopnseData) {
        __autoreleasing NSString * dataString=[[NSString alloc] initWithData:resopnseData encoding:NSUTF8StringEncoding];
#if kHXEnableLog
        NSLog(@"返回数据:%@",dataString);
#endif
        NSDictionary *responseDicationary=[self objectFromJSONString:dataString];
        
        netResult.code = [NSString stringWithFormat:@"%@",[responseDicationary objectForKey:kHXcode]];
        netResult.message = responseDicationary[kHXmessage];
        
        id dataT=responseDicationary[kHXbody];
        
        if (dataT && ![dataT isEqual:[NSNull null]] ) {
            if (dblock) {
                NSArray *tempList=dblock(dataT);
                if ([tempList count]>0) {
                    netResult.result=[NSMutableArray arrayWithArray:tempList];
                }
            }
        }
    }
    
    return netResult;
    
}


@end
