//
//  MaskView.m
//  HXInvestigate
//
//  Created by 董富强 on 2017/7/5.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "MaskView.h"
#pragma mark - Private
static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw,fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);                // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);   // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);     // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);      // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);    // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

@implementation MaskView

- (instancetype)initWithFrame:(CGRect)frame  {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight withRadii:CGSizeMake(10, 10)];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    
//    
//    
//}

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}


///** 添加圆角 */
//- (instancetype)roundToSize:(CGSize)size
//{
//    int w = size.width;
//    int h = size.height;
//    
//    UIImage *img = self;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (uint32_t)kCGImageAlphaPremultipliedFirst);
//    CGRect rect = CGRectMake(0, 0, w, h);
//    
//    CGContextBeginPath(context);
//    addRoundedRectToPath(context, rect, 5, 5);
//    CGContextClosePath(context);
//    CGContextClip(context);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    UIImage* image2 =  [UIImage imageWithCGImage:imageMasked];
//    CGContextRelease(context);
//    CGImageRelease(imageMasked);
//    CGColorSpaceRelease(colorSpace);
//    return image2;
//}

@end
