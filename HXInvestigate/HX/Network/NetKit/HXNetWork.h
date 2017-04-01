//
//  HXNetWork.h
//  AFNetworking Example
//
//  Created by 董富强 on 16/7/12.
//
//

#import <Foundation/Foundation.h>

#import "HXNetworkResult.h"

//正式的时候不用导入这两个头文件
//#import "HXEntities.h"
//#import "BSExtKit.h"


typedef NS_ENUM(NSInteger, _NetworkType){
    _NetworkTypeJOSN=0,///默认请求,返回的是json
    _NetworkTypeXML=1,///返回的是xml
    _NetworkTypeValue1=2 ///其他类型
};

/**
 *	网络处理完成回调block
 *	@param operation 请求对象operation
 *	@param networkResult  服务器返回的数据
 *	@param error     错误信息
 */
typedef void(^networkCompletionBlock)(NSURLSessionTask *task , HXNetworkResult * networkResult, NSError * error);

/**
 *	网络上传进度
 *	@param bytesWritten              写入的字节
 *	@param totalBytesWritten         总写入的字节
 *	@param totalBytesExpectedToWrite 要写入的总字节
 */
typedef void (^networkUploadProgressBlock)(NSURLSessionTask *task,NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite ,NSDictionary * info);

/**
 *	网络下载进度
 *	@param bytesRead                读字节
 *	@param totalBytesRead           总读入的字节
 *	@param totalBytesExpectedToRead 要读入的总字节
 */
typedef void(^networkDownloadProgressBlock)(NSURLSessionTask *task,NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead,NSDictionary * info);

/**
 *	网络处理类
 */
@interface HXNetWork : NSObject


@property (nonatomic,strong)NSMutableDictionary * cacheHeaderDictionary;


/**
 *	单例类
 *	@return 实例
 */
+ (HXNetWork *)shareInstance;


/**
 *	得到Request请求
 *	@param url		连接
 *	@param header	请求头
 *	@return Request
 */
- (NSMutableURLRequest *)getURLRequestWithURL:(NSURL *)url header:(NSDictionary *)header;


/**
 *	从字典中得到具体的body体
 *	@param parmenters	字典，包括具体的json题
 *	@param en			编码格式
 *	@return 构造完成的body文件
 */
- (NSData *)getBodyStringFromParameters:(NSDictionary *)parmenters encoden:(NSStringEncoding)en;



/**
 *	发起请求的处理类
 *	@param data						body数据
 *	@param url						url
 *	@param hedader					header
 *	@param comblock                 网络完成回调
 *	@param uploadprogressBlock		上传进度回调
 *	@param downloadProgressBlock	下载进度回调
 *	@param isAnimation				是否动画
 *	@param info						预留信息
 *	@param timeoutInterval			超时时间
 *	@return operation
 */
- (NSURLSessionTask *)startRequestTaskWithBodyData:(NSData *)data
                                               url:(NSURL *)url
                                        httpHeader:(NSDictionary *)hedader
                                   completionBlock:(void (^)(NSURLSessionTask *operation, id responseObject,NSError *error))comblock
                               uploadProgressBlock:(void (^)(NSURLSessionTask *operation,NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))uploadprogressBlock
                             downloadProgressBlock:(void (^)(NSURLSessionTask *operation,NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))downloadProgressBlock
                                         animation:(BOOL)isAnimation
                                              info:(NSDictionary *)info
                                   timeoutInterval:(NSTimeInterval)timeoutInterval;



/**
 *	具体的业务处理，返回处理结果
 *	@param resopnseData	服务器返回的数据
 *	@param requestCode	请求码
 *	@param dblock		具体业务处理，交给具体结果处理，返回处理的结果
 *	@return 处理结果
 */
- (HXNetworkResult *)getNetworkResultWithData:(NSData *)resopnseData requestCode:(NSString *)requestCode withBusinessLogicBlock:(NSArray* (^)(id dataObject))dblock;


/**
 *	得到有效数据,如果为nil，返回NSNull对象
 *	@param obj	对象
 *	@return id
 */
-(id)getEffectiveObject:(id)obj;

/**
 *	jsonData转对象
 *	@param jsonData	json数据
 *	@return 解析后得对象
 */
- (id)objectFromJSONData:(NSData *)jsonData;

/**
 *	json字符串转对象
 *	@param jsonString	json字符串
 *	@return 解析后得对象
 */
- (id)objectFromJSONString:(NSString *)jsonString;

/**
 *	字典对象转json字符串
 *	@param dicationary	字典
 *	@return json字符串
 */
- (NSString *)getJSONStringWithDicationary:(NSDictionary *)dicationary;

/**
 *	字典对象转json字符串
 *	@param dictionary	字典
 *	@return json数据
 */
- (NSData *)getJSONDataWithDicationary:(NSDictionary *)dictionary;





@end
