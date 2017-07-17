//
//  APPManager.m
//  HBBForPrincipal
//
//  Created by 董富强 on 16/7/20.
//  Copyright © 2016年 HXKid. All rights reserved.
//

#import "APPManager.h"
#import "HXAppInfo.h"
#import "MJExtension.h"
#import "AFNetworking.h"

@interface APPManager ()

@end

@implementation APPManager

+ (instancetype)factoryAPPManager {
    APPManager *appM = [[APPManager alloc] init];
    return appM;
    
}

- (void)verifyRequireUpdateToNewVersionWithAppId:(NSString *)appleId andCom:(void(^)(BOOL isRequireNew,NSString *newVersion))comBlock {
    //[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",HX_APPLE_ID]]
    
    NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appleId?appleId:HX_APPLE_ID];
    NSURL *storeURL = [NSURL URLWithString:storeString];
    
    NSLog(@"获取AppStore上APP信息的地址：%@",storeString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:storeURL];
    [request setHTTPMethod:@"GET"];
    
    AFURLSessionManager *afsessionM = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[afsessionM dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"AppStore 上拉取的APP基本信息：%@",responseObject);
        
        NSString *currentAppVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        if (responseObject&&[responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *appData = [NSDictionary dictionaryWithDictionary:responseObject];
            
            if ([[appData objectForKey:@"resultCount"] integerValue]) {
                
                HXAppInfo *appStoreAppInfo = [HXAppInfo mj_objectWithKeyValues:[[appData objectForKey:@"results"] lastObject]];
                if ([currentAppVersion compare:appStoreAppInfo.version options:NSNumericSearch] == NSOrderedAscending) { //发现需要更新
                    
                    comBlock(YES,appStoreAppInfo.version);
                } else { //现在就是最新的版本
                    
                    comBlock(NO,currentAppVersion);
                }
                
            } else {
                
                comBlock(NO,currentAppVersion);
            }
        } else {
            //空值 无版本
            comBlock(NO,currentAppVersion);
        }
        
    }] resume];
    
}

@end
