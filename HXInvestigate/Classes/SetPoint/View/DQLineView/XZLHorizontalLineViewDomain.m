//
//  XZLHorizontalLineViewDomain.m
//  HXInvestigate
//
//  Created by 董富强 on 2017/7/4.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "XZLHorizontalLineViewDomain.h"

@implementation XZLHorizontalLineViewDomain

- (instancetype)init {
    
    if (self = [super init]) {
        
        _allDaySecs = 24*60*60;
        _TwoWeeksSecs = 14*_allDaySecs;
        _OneMonthSecs = 30*_allDaySecs;
        
        _actualOriginValue = 10.0;
        _actualLastValue = [UIScreen mainScreen].bounds.size.width-_actualOriginValue;
    }
    return self;
}


//转换 从一个业务值 得到相应的 实际值
- (CGFloat)convertToActualValueFromBusinessValue:(long long)busValue {
    
    long long busOValue = _businessOriginValue;
    long long busLValue = _businessLastValue;
    
    long long busDifValue = busLValue - busOValue;
    
    CGFloat actualDifValue =
    _actualLastValue - _actualOriginValue;
    
    int busScale = (int)((busValue - busOValue)*1000/busDifValue);
    
    return actualDifValue * busScale * 0.001;
}

//转换 从一个实际值 得到形影的 业务值
- (long long)convertToBusinessValueFromActualValue:(CGFloat)actualValue {
    
    CGFloat actualDifValue = _actualLastValue - _actualOriginValue;
    int actualScale = (int)((actualValue - _actualOriginValue)*1000/actualDifValue);
    
    long long busOValue = _businessOriginValue;
    long long busLValue = _businessLastValue;
    
    long long busDifValue = busLValue - busOValue;
    
    return _businessOriginValue + (long long)(actualScale * busDifValue * 0.001);
}

@end












