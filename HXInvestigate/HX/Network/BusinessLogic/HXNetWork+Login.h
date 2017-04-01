//
//  HXNetWork+Login.h
//  AFNetworking Example
//
//  Created by 董富强 on 16/7/12.
//
//

#import "HXNetWork.h"

@interface HXNetWork (Login)


- (NSURLSessionTask *)loginWithUserName:(HXUser *)userReq
                 networkCompletionBlock:(networkCompletionBlock)completionBlock
                              animation:(BOOL)animation
                                   info:(NSDictionary *)info;

@end
