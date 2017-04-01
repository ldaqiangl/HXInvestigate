//
//  BSBlurView.h
//  HXInvestigate
//
//  Created by 董富强 on 16/7/27.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^WillShowBlurViewBlcok)(void);
typedef void(^DidShowBlurViewBlcok)(BOOL finished);

typedef void(^WillDismissBlurViewBlcok)(void);
typedef void(^DidDismissBlurViewBlcok)(BOOL finished);


static NSString * const BSBlurViewKey = @"BSBlurViewKey";

static NSString * const BSRealTimeWillShowBlurViewBlcokBlcokKey = @"BSRealTimeWillShowBlurViewBlcokBlcokKey";
static NSString * const BSRealTimeDidShowBlurViewBlcokBlcokKey = @"BSRealTimeDidShowBlurViewBlcokBlcokKey";

static NSString * const BSRealTimeWillDismissBlurViewBlcokKey = @"BSRealTimeWillDismissBlurViewBlcokKey";
static NSString * const BSRealTimeDidDismissBlurViewBlcokKey = @"BSRealTimeDidDismissBlurViewBlcokKey";

typedef NS_ENUM(NSInteger, BSBlurStyle) {
    // 垂直梯度背景从黑色到半透明的。
    BSBlurStyleBlackGradient = 0,
    // 类似UIToolbar的半透明背景
    BSBlurStyleTranslucent,
    // 黑色半透明背景
    BSBlurStyleBlackTranslucent,
    // 纯白色
    BSBlurStyleWhite
};

@interface BSBlurView : UIView

/**
 *  Default is BSBlurStyleTranslucent
 */
@property (nonatomic, assign) BSBlurStyle blurStyle;

@property (nonatomic, assign) BOOL showed;

// Default is 0.3
@property (nonatomic, assign) NSTimeInterval showDuration;

// Default is 0.3
@property (nonatomic, assign) NSTimeInterval disMissDuration;

/**
 *  是否触发点击手势，默认关闭
 */
@property (nonatomic, assign) BOOL hasTapGestureEnable;

@property (nonatomic, copy) WillShowBlurViewBlcok willShowBlurViewcomplted;
@property (nonatomic, copy) DidShowBlurViewBlcok didShowBlurViewcompleted;

@property (nonatomic, copy) WillDismissBlurViewBlcok willDismissBlurViewCompleted;
@property (nonatomic, copy) DidDismissBlurViewBlcok didDismissBlurViewCompleted;


- (void)showBlurViewAtView:(UIView *)currentView;

- (void)showBlurViewAtViewController:(UIViewController *)currentViewContrller;

- (void)disMiss;


@end


@interface UIView (BSBlurView)

@property (nonatomic, copy) WillShowBlurViewBlcok willShowBlurViewcomplted;
@property (nonatomic, copy) DidShowBlurViewBlcok didShowBlurViewcompleted;


@property (nonatomic, copy) WillDismissBlurViewBlcok willDismissBlurViewCompleted;
@property (nonatomic, copy) DidDismissBlurViewBlcok didDismissBlurViewCompleted;

- (void)showRealTimeBlurWithBlurStyle:(BSBlurStyle)blurStyle;
- (void)showRealTimeBlurWithBlurStyle:(BSBlurStyle)blurStyle hasTapGestureEnable:(BOOL)hasTapGestureEnable;
- (void)disMissRealTimeBlur;

@end

