//
//  HXNetworkResult.h
//  AFNetworking Example
//
//  Created by 董富强 on 16/7/12.
//
//

#import <Foundation/Foundation.h>

@interface HXNetworkResult : NSObject

/**请求码*/
@property (nonatomic,copy) NSString *requestCode;

/**返回码 0-成功 其他失败*/
@property (nonatomic,copy) NSString *code;
@property (nonatomic,assign,readonly) BOOL isSuccess;

/**提示信息*/
@property (nonatomic,copy) NSString *message;

/**处理过得数据,实体类*/
@property (nonatomic,strong) NSMutableArray *result;

/**返回的data数据*/
@property (nonatomic,strong) NSData *data;

/*错误*/
@property (nonatomic,strong) NSError *error;

/**预留参数*/
@property (nonatomic,strong) NSDictionary *info;


@end
