//
//  DQTaskOperation.h
//  HXInvestigate
//
//  Created by 董富强 on 2017/6/6.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQTaskOperation : NSOperation


+ (DQTaskOperation *)getBlock:(void(^)())taskBlock;

@end
