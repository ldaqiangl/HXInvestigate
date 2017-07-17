//
//  APPManager.h
//  HBBForPrincipal
//
//  Created by 董富强 on 16/7/20.
//  Copyright © 2016年 HXKid. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HX_APPLE_ID @"1121926967"

@interface APPManager : NSObject

/**
 *  工厂函数
 */
+ (instancetype)factoryAPPManager;

/**
 *  验证APP是否有需要更新的版本
 *
 *  @param appleId  appleID （传nil表示默认用宏定义的:HX_APPLE_ID）
 *  @param comBlock 回调bool的验证结果
 */
- (void)verifyRequireUpdateToNewVersionWithAppId:(NSString *)appleId andCom:(void(^)(BOOL isRequireNew,NSString *newVersion))comBlock;


@end
