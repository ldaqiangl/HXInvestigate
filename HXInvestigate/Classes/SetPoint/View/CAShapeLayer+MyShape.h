//
//  CAShapeLayer+MyShape.h
//  HXInvestigate
//
//  Created by 董富强 on 2017/7/5.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAShapeLayer (MyShape)

- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;


@end