//
//  XZLHorizontalLineView.h
//  HXInvestigate
//
//  Created by 董富强 on 2017/7/3.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XZLHorizontalLineViewDomain;
@interface XZLHorizontalLineView : UIView

/** 是否动画显示线条 */
@property (nonatomic, assign) BOOL isAnimateDisplay;

- (void)strokeHorizontalLine;
- (void)updateHorizontalLineWithDataModel:(NSArray *)nodeRanges;

@end



typedef enum XZLHorizontalLineNodeRangeStyle {
    
    XZLHorizontalLineNodeRangeDashStyle = 0,
    XZLHorizontalLineNodeRangeRoundCapLineStyle = 1,
    XZLHorizontalLineNodeRangeButtCapLineStyle = 2,
    
} XZLHorizontalLineNodeRangeStyle;

@interface XZLHorizontalLineNodeRange : NSObject

@property (nonatomic, assign) XZLHorizontalLineNodeRangeStyle rangeLineStyle;

@property (nonatomic, assign) CGFloat startX;
@property (nonatomic, assign) CGFloat endX;

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, copy) NSString *colorValue;

@end









