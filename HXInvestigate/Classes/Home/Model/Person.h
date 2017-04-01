//
//  Person.h
//  框架演示demo
//
//  Created by 董富强 on 16/7/16.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, assign) NSInteger userType;//0：家长 1：教师 2：园长
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, assign) NSInteger sex;//0:女 1:男


+ (Person *)personWithDict:(NSDictionary *)pDict;

@end
