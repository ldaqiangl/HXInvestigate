//
//  CAShapeLayer+MyShape.m
//  HXInvestigate
//
//  Created by 董富强 on 2017/7/5.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "CAShapeLayer+MyShape.h"

@implementation CAShapeLayer (MyShape)

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath *rounded =
    [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [CAShapeLayer layer];
    [shape setPath:rounded.CGPath];
    
    self.mask = shape;
}
@end
