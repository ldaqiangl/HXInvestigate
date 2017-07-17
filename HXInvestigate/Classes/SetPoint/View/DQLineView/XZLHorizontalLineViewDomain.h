//
//  XZLHorizontalLineViewDomain.h
//  HXInvestigate
//
//  Created by 董富强 on 2017/7/4.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum XZLHorizontalLineViewDomainStyle {
    
    XZLHorizontalLineViewDomainTwoWeeksStyle = 0,//按照两周
    XZLHorizontalLineViewDomainOneMonthStyle = 1,//按照一个月
    
} XZLHorizontalLineViewDomainStyle;

@interface XZLHorizontalLineViewDomain : NSObject

/** 时域类型 */
@property (nonatomic, assign) XZLHorizontalLineViewDomainStyle lineDomainStyle;
/** 以秒计 一整天总时间 */
@property (nonatomic, assign, readonly) long long allDaySecs;
/** 以秒计 两周总时间 */
@property (nonatomic, assign, readonly) long long TwoWeeksSecs;
/** 以秒计 一个月总时间 */
@property (nonatomic, assign, readonly) long long OneMonthSecs;

/** 时间轴起始值（业务值） */
@property (nonatomic, assign) long long businessOriginValue;
/** 时间轴末尾值（业务值） */
@property (nonatomic, assign) long long businessLastValue;

/** 业务起始值对应的屏幕尺寸实际值 */
@property (nonatomic, assign) CGFloat actualOriginValue;
/** 业务末尾值对应的屏幕尺寸实际值 */
@property (nonatomic, assign) CGFloat actualLastValue;

//转换 从一个业务值 得到相应的 实际值
- (CGFloat)convertToActualValueFromBusinessValue:(long long)busValue;
//转换 从一个实际值 得到相应的 业务值
- (long long)convertToBusinessValueFromActualValue:(CGFloat)actualValue;

@end










