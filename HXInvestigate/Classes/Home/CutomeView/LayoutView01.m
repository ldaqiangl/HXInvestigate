//
//  LayoutView01.m
//  HXInvestigate
//
//  Created by 董富强 on 08/04/2017.
//  Copyright © 2017 董富强. All rights reserved.
//

#import "LayoutView01.h"

#define ORANGE_COLOR    [UIColor colorWithRed:1 green:0.6 blue:0 alpha:1]
#define AQUA_COLOR    [UIColor colorWithRed:0 green:0.6745 blue:0.8039 alpha:1]


@interface LayoutView01 ()

@end

@implementation LayoutView01

- (instancetype)init {
    
    if (self = [super init]) {
        self.backgroundColor = [UIColor blueColor];
        
//        UIImageView *imgView = [[UIImageView alloc] init];
//        imgView.translatesAutoresizingMaskIntoConstraints = NO;
//        self.imgView = imgView;
//        [self addSubview:self.imgView];
//        
//        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_imgView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
//        
//        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:imgView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
//        
//        [self addConstraints:@[centerX,centerY]];
        
    }
    return self;
}

- (void)updateImgView:(NSString *)name {
    
    _imgView.image = [UIImage imageNamed:name];
    
    [self testAmbiguidty];
    //[_imgView invalidateIntrinsicContentSize];
    NSLog(@"======>> %@",NSStringFromCGSize(_imgView.intrinsicContentSize));
}

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path;
    
    // Calculate offset from frame for 170x170 art
    CGFloat dx = (self.frame.size.width - 170) / 2.0f;
    CGFloat dy = (self.frame.size.height - 170);

    // Draw a shadow
    CGRect drect = CGRectMake(8 + dx, 8 + dy, 160, 160);
    path = [UIBezierPath bezierPathWithRoundedRect:drect cornerRadius:0];
    [[[UIColor blackColor] colorWithAlphaComponent:0.3f] set];
    [path fill];
    
    // Draw shape with outline
    rect.origin = CGPointMake(dx, dy);
    path = [UIBezierPath bezierPathWithRoundedRect:drect cornerRadius:0];
    [[UIColor cyanColor] set];
    path.lineWidth = 6;
    [path stroke];
    
    [ORANGE_COLOR set];
    [path fill];
}

- (CGSize)intrinsicContentSize
{
    // Fixed content size - base + frame
    return CGSizeMake(170, 170);
}

#define USE_ALIGNMENT_RECTS 1
#if USE_ALIGNMENT_RECTS
- (CGRect)frameForAlignmentRect:(CGRect)alignmentRect
{
    // 170 / 160 = 1.0625
    CGRect rect = (CGRect){.origin = alignmentRect.origin};
    rect.size.width = alignmentRect.size.width * 1.06250;
    rect.size.height = alignmentRect.size.height * 1.06250;
    return rect;
}

- (CGRect)alignmentRectForFrame:(CGRect)frame
{
    // 160 / 170 = 0.94117
    CGRect rect;
    CGFloat dy = (frame.size.height - 170) / 2.0; // account for vertical flippage
    rect.origin = CGPointMake(frame.origin.x, frame.origin.y + dy);
    rect.size.width = frame.size.width * 0.94117;
    rect.size.height = frame.size.height * 0.94117;
    return rect;
}
#endif

@end
