//
//  MTL_NIL_VALUE.m
//  亿人帮
//
//  Created by 董富强 on 15/7/6.
//  Copyright (c) 2015年 DYYY. All rights reserved.
//


@implementation MTLModel (MTL_NIL_VALUE)

- (void)setNilValueForKey:(NSString *)key {
    [self setValue:@0 forKey:key];
}

@end
