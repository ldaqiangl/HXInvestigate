//
//  XZLHorizontalLineView.m
//  HXInvestigate
//
//  Created by 董富强 on 2017/7/3.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "XZLHorizontalLineView.h"

@interface XZLHorizontalLineView ()
<CAAnimationDelegate>
{
    NSInteger _layerIndex;
}
/** 路径数组 */
@property (nonatomic, strong) NSMutableArray *linePathsArr;
/** shape layer 数组 */
@property (nonatomic, strong) NSMutableArray *shapeLinesArr;

@property (nonatomic, strong) CABasicAnimation *pathAnimation;

@end
@implementation XZLHorizontalLineView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)strokeHorizontalLine {
    
}

- (void)updateHorizontalLineWithDataModel:(NSArray *)nodeRanges {
    
    // clear work
    if (self.shapeLinesArr.count > 0) {
        
        for (CALayer *subLayer in self.shapeLinesArr) {
            
            [subLayer removeAllAnimations];
            [subLayer removeFromSuperlayer];
        }
        
        [self.shapeLinesArr removeAllObjects];
        [self.linePathsArr removeAllObjects];
    }
    
    // 添加图层 、路径 和动画
    _layerIndex = 0;
    for (NSInteger i = 0; i < nodeRanges.count; i++) {
        
        XZLHorizontalLineNodeRange *nodeRange = nodeRanges[i];
        
        //line layer
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.strokeStart = 0.0;
        lineLayer.strokeEnd = 1.0;
        lineLayer.position = CGPointMake(0, self.bounds.size.height * 0.5);
        lineLayer.backgroundColor = [UIColor clearColor].CGColor;
        [self.shapeLinesArr addObject:lineLayer];
        
        CGFloat startX = nodeRange.startX, endX = nodeRange.endX;
        if (nodeRange.rangeLineStyle == XZLHorizontalLineNodeRangeDashStyle) {
            
            lineLayer.lineDashPhase = 100;
            lineLayer.lineDashPattern = @[[NSNumber numberWithDouble:0.5],[NSNumber numberWithDouble:5.0]];
            lineLayer.lineCap = kCALineCapRound;
            lineLayer.zPosition = 0.1;
        } else if (nodeRange.rangeLineStyle == XZLHorizontalLineNodeRangeRoundCapLineStyle) {
            
            lineLayer.lineCap = kCALineCapRound;
            lineLayer.zPosition = 0.2;
            startX = startX + 2.0;
            endX = endX - 2.0;
        } else {
            
            lineLayer.lineCap = kCALineCapButt;
            lineLayer.zPosition = 1.0;
        }
        
        lineLayer.lineJoin = kCALineJoinRound;
        lineLayer.lineWidth = nodeRange.lineWidth;
        lineLayer.fillColor = [UIColor clearColor].CGColor;
        lineLayer.strokeColor = [UIColor colorWithHexString_Ext:nodeRange.colorValue].CGColor;
        
        //path
        UIBezierPath *nodeRangeLinePath = [UIBezierPath bezierPath];
        [nodeRangeLinePath moveToPoint:CGPointMake(startX, 0)];
        [nodeRangeLinePath addLineToPoint:CGPointMake(endX, 0)];
        [self.linePathsArr addObject:nodeRangeLinePath];
        lineLayer.path = nodeRangeLinePath.CGPath;
        
        // is animate
        if (_isAnimateDisplay) {
            
            if (i == 0) {
                
                [self.layer addSublayer:lineLayer];
                
                UIGraphicsBeginImageContext(self.frame.size);
                [CATransaction begin];

                [lineLayer addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
                
                [CATransaction commit];
                UIGraphicsEndImageContext();
            }
        } else {
            
            [self.layer addSublayer:lineLayer];
        }
    }
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
//    for (NSInteger i = 0; i < self.shapeLinesArr.count; i++) {
//        
//        CAShapeLayer *lineLayer = self.shapeLinesArr[i];
//        lineLayer.frame =
//        CGRectMake(lineLayer.frame.origin.x,
//                   lineLayer.frame.origin.y,
//                   lineLayer.frame.size.width,
//                   self.bounds.size.height);
//    }
    
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    
    if (flag) {
        
        _layerIndex++;
        
        if (_layerIndex < self.shapeLinesArr.count) {
            
            CAShapeLayer *shapeLayer = self.shapeLinesArr[_layerIndex];
            [self.layer addSublayer:shapeLayer];
            
            UIGraphicsBeginImageContext(self.frame.size);
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            
            [shapeLayer addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
            
            [CATransaction commit];
            UIGraphicsEndImageContext();
            
        }
    }
}


#pragma mark - -> 懒加载

- (CABasicAnimation *)pathAnimation {
    
    if (!_pathAnimation) {
        
        _pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _pathAnimation.duration = 0.3;
        _pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _pathAnimation.fromValue = @0.0f;
        _pathAnimation.toValue = @1.0f;
        _pathAnimation.fillMode = kCAFillModeForwards;
        _pathAnimation.delegate = self;
        _pathAnimation.removedOnCompletion = YES;
    }
    return _pathAnimation;
}

- (NSMutableArray *)shapeLinesArr {
    
    if (!_shapeLinesArr) {
        
        _shapeLinesArr = [NSMutableArray array];
    }
    return _shapeLinesArr;
}

- (NSMutableArray *)linePathsArr {
    
    if (!_linePathsArr) {
        
        _linePathsArr = [NSMutableArray array];
    }
    return _linePathsArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end




/*
 
 CAShapeLayer *shapeLayer = [CAShapeLayer layer];
 
 shapeLayer.strokeStart = 0.0;
 shapeLayer.strokeEnd = 1;
 
 UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.layerView.bounds];
 
 shapeLayer.path = path.CGPath;
 
 shapeLayer.fillColor = [UIColor whiteColor].CGColor;
 shapeLayer.lineWidth = 2.0;
 shapeLayer.lineDashPhase = 100;
 shapeLayer.lineCap = kCALineCapRound;
 shapeLayer.lineDashPattern = @[[NSNumber numberWithDouble:0.5],[NSNumber numberWithDouble:5.0]];
 shapeLayer.strokeColor = [UIColor blueColor].CGColor;
 
 [self.layerView.layer addSublayer:shapeLayer];
 
 [CATransaction begin];
 
 CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
 an.duration = 3.0;
 an.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 an.fromValue = @(0.0);
 an.toValue = @(1.0);
 an.fillMode = kCAFillModeForwards;
 an.removedOnCompletion = YES;
 [shapeLayer addAnimation:an forKey:@"strokeEndAnimation"];
 
 [CATransaction commit];
 */



@implementation XZLHorizontalLineNodeRange


@end













