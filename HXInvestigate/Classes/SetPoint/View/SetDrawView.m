//
//  SetDrawView.m
//  HXInvestigate
//
//  Created by 董富强 on 2016/10/28.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "SetDrawView.h"
#import <CoreText/CoreText.h>

@implementation SetDrawView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //1.
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.Matrix(矩阵) CTM（CellTransferMatrix 单元传送矩阵） 
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //3.
    CGMutablePathRef path = CGPathCreateMutable();
    //    CGPathAddRect(path, NULL, self.bounds);
    CGPathAddEllipseInRect(path, NULL, self.bounds);
    
    
    
    //4.
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello World!"
                                     "创建绘制的区域，CoreText本身支持各种文字排版的区域，"
                                     "我们这里简单地将UIView的整个界面作为排版区域。"
                                     "为了加深理解，加以读者将该步骤的代码替换成如下代码，"
                                     "测试设设置不同的绘制区域带来的界面变化。"];
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame =
    CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attString.length), path, NULL);
    
    //5.
    CTFrameDraw(frame, context);
    
    
    CFRelease(path);
    CFRelease(frame);
    CFRelease(framesetter);

}

@end
