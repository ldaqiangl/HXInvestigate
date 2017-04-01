//
//  CustomeView.h
//  框架演示demo
//
//  Created by 董富强 on 16/7/17.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ReactiveCocoa.h>
#import <AFNetworking/AFNetworking.h>
#import "Aspects.h"

typedef NS_OPTIONS(NSInteger, CustomeViewEventType) {
    eCustomeViewBlueBtnClickedEventType = 0,
};

@interface CustomeView : UIView

@property (weak, nonatomic) IBOutlet UIButton *customBtn;

- (IBAction)customeBtnClick:(id)sender;

- (RACSignal *)customeViewEventSigalWith:(CustomeViewEventType)eventType;

@end
