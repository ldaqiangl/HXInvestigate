//
//  DQTaskOperation.m
//  HXInvestigate
//
//  Created by 董富强 on 2017/6/6.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "DQTaskOperation.h"

@interface DQTaskOperation ()
@property (nonatomic, copy) void(^taskBlock)();
@end
@implementation DQTaskOperation

- (void)main {
    
    NSLog(@"执行 封装的主要方法 main。。。");
    
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        
//    });
    self.taskBlock();

    NSLog(@"同步到主线程的任务执行完成");
}


+ (DQTaskOperation *)getBlock:(void (^)())taskBlock {
    
    DQTaskOperation *op = [[DQTaskOperation alloc] init];
    op.taskBlock = taskBlock;
    return op;
}
@end
