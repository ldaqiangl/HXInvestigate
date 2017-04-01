//
//  HomeModelViewController.h
//  框架演示demo
//
//  Created by 董富强 on 16/7/16.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface HomeModelViewController : UIViewController

@property (nonatomic, strong) RACSubject *delegateSigal;

@end
