//
//  Person.m
//  框架演示demo
//
//  Created by 董富强 on 16/7/16.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "Person.h"

@implementation Person
+ (Person *)personWithDict:(NSDictionary *)pDict {
    Person *p = [[Person alloc] init];
    p.age = [NSString stringWithFormat:@"%@",pDict[@"age"]];
    p.name = [NSString stringWithFormat:@"%@",pDict[@"name"]];
    
    return p;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"person: -> name:%@ , age:%@",self.name,self.age];
}
@end
