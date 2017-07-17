//
//  XZLHorizontalLineHeaderView.m
//  HXInvestigate
//
//  Created by 董富强 on 2017/7/4.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "XZLHorizontalLineHeaderView.h"
#define IOS7_OR_LATER [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

@interface XZLHorizontalLineHeaderBackView : UIView

@property (nonatomic, weak) XZLHorizontalLineViewDomain *timeLineDomain;

@end
@implementation XZLHorizontalLineHeaderBackView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat lineW = 1;
    CGFloat lineY = rect.size.height-lineW-3;
    
    CGFloat startX = _timeLineDomain.actualOriginValue + lineW * 0.5;
    CGFloat endX = _timeLineDomain.actualLastValue - lineW * 0.5;
    
    NSMutableArray *timeFlags = [NSMutableArray array];
    NSString *startYMD =
    [[self class] getTargetDateStringWithStyle:@"M月d日"
                                  andTimestamp:
     [NSString stringWithFormat:@"%lld",_timeLineDomain.businessOriginValue*1000]];
    NSString *endYMD =
    [[self class] getTargetDateStringWithStyle:@"M月d日"
                                  andTimestamp:
     [NSString stringWithFormat:@"%lld",_timeLineDomain.businessLastValue*1000]];
    NSString *midYMD =
    [[self class] getTargetDateStringWithStyle:@"M月d日"
                                  andTimestamp:
     [NSString stringWithFormat:@"%lld",
      (long long)((_timeLineDomain.businessOriginValue+_timeLineDomain.businessLastValue)*1000*0.5)]];
    [timeFlags addObject:startYMD];
    [timeFlags addObject:midYMD];
    [timeFlags addObject:endYMD];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    // draw HorizontalLine
    CGContextMoveToPoint(ctx, startX, lineY);
    CGContextAddLineToPoint(ctx, endX, lineY);
    
    CGContextSetLineWidth(ctx, lineW);
    CGContextSetStrokeColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //小竖线
    UIFont *font = [UIFont systemFontOfSize:11];
    
    CGFloat tipAddX = (endX-startX)/(timeFlags.count - 1);
    CGFloat tipLineH = 10;
    CGFloat tipLineY = lineY-lineW*0.5-tipLineH;
    
    CGFloat textW = 100, textH = 20;
    CGFloat textX = startX, textY = tipLineY - textH;
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    for (NSInteger i = 0; i < timeFlags.count; i++) {
        
        CGFloat tipX = tipAddX * i + startX;
        
        CGContextMoveToPoint(ctx, tipX, lineY + lineW * 0.5);
        CGContextSetLineWidth(ctx, lineW);
        //        CGFloat dash[] = {6, 5};
        //        CGContextSetLineCap(ctx, kCGLineCapRound);
        //        CGContextSetLineDash(ctx, 0.0, dash, 2);
        CGContextAddLineToPoint(ctx, tipX, tipLineY);
        CGContextStrokePath(ctx);
        
        CGSize textSize = [[self class] sizeOfString:timeFlags[i] withWidth:textW font:font];
        textW = textSize.width;
        textH = textSize.height;
        
        NSTextAlignment alignment;
        if (i == 0) {
            
            alignment = NSTextAlignmentLeft;
            textX = tipX - lineW * 0.5;
        } else if (i == timeFlags.count-1) {
            
            alignment = NSTextAlignmentRight;
            textX = tipX - textW + lineW * 0.5;
        } else {
            
            textX = tipX - textW * 0.5;
            alignment = NSTextAlignmentCenter;
        }
        
        CGRect textRect = CGRectMake(textX, textY, textW, textH);
        [self drawTextInContext:ctx text:timeFlags[i] inRect:textRect font:font andAlign:alignment];
    }
    
    CGContextRestoreGState(ctx);
}

- (void)drawTextInContext:(CGContextRef)ctx
                     text:(NSString *)text
                   inRect:(CGRect)rect
                     font:(UIFont *)font
                 andAlign:(NSTextAlignment)alignMent {
    
    if (IOS7_OR_LATER) {
        
        NSMutableParagraphStyle *priceParagraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        priceParagraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        priceParagraphStyle.alignment = alignMent;
        
        [text drawInRect:rect
          withAttributes:@{NSParagraphStyleAttributeName : priceParagraphStyle, NSFontAttributeName : font}];
    } else {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [text drawInRect:rect
                withFont:font
           lineBreakMode:NSLineBreakByTruncatingTail
               alignment:alignMent];
#pragma clang diagnostic pop
    }
}


+ (CGSize)sizeOfString:(NSString *)text withWidth:(float)width font:(UIFont *)font {
    
    CGSize size = CGSizeMake(width, MAXFLOAT);
    
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        size = [text boundingRectWithSize:size
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:tdic
                                  context:nil].size;
    } else {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    
    return size;
}


+ (NSString *)getTargetDateStringWithStyle:(NSString *)styleString
                              andTimestamp:(NSString *)timestamp {
    
    NSString *displayTime = @"";
    
    NSString *dateStr = timestamp;
    long long int exchangedTime = dateStr.doubleValue/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:exchangedTime];
    
    // 1.将服务器返回的时间格式化为NSDate
    NSDateFormatter *DateF = [[NSDateFormatter alloc] init];
    DateF.locale = [NSLocale currentLocale];
    DateF.dateFormat = @"YYYY-MM-dd HH:mm:ss Z";
    NSDate *createdTime = [DateF dateFromString:[DateF stringFromDate:confromTimesp]];
    
    DateF.dateFormat = styleString;
    displayTime = [DateF stringFromDate:createdTime];
    
    return displayTime;
}

@end


@interface XZLHorizontalLineHeaderView ()

@property (nonatomic, copy) SwitchCallBack switchCallBack;
@property (nonatomic, weak) UISegmentedControl *segment;
//@property (nonatomic, strong) CAShapeLayer *lineLayer;

@end
@implementation XZLHorizontalLineHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
                            andCallBack:(SwitchCallBack)switchCallBack {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[XZLHorizontalLineHeaderBackView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.switchCallBack = switchCallBack;
        [self createView];
    }
    return self;
}

- (void)createView {
    
    UISegmentedControl *segment =
    [[UISegmentedControl alloc] initWithItems:@[@"2周",@"1月"]];
    [segment setTintColor:[UIColor greenColor]];
    [segment setBackgroundColor:[UIColor whiteColor]];
    segment.layer.cornerRadius = 5;
    segment.layer.masksToBounds = YES;
    [segment addTarget:self action:@selector(segmentSwitch:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:segment];
    self.segment = segment;
    
    //line layer
//    CAShapeLayer *lineLayer = [CAShapeLayer layer];
//    lineLayer.strokeStart = 0.0;
//    lineLayer.strokeEnd = 1.0;
//    lineLayer.position = CGPointMake(0, self.bounds.size.height * 0.5);
//    lineLayer.backgroundColor = [UIColor clearColor].CGColor;
//    self.lineLayer = lineLayer;
//    [self.layer addSublayer:lineLayer];
}

- (void)setTimeLineDomain:(XZLHorizontalLineViewDomain *)timeLineDomain {
    
    _timeLineDomain = timeLineDomain;
    
    self.segment.frame =
    CGRectMake(timeLineDomain.actualOriginValue, timeLineDomain.actualOriginValue, 80, 25);
    self.segment.selectedSegmentIndex = timeLineDomain.lineDomainStyle;
    
    [(XZLHorizontalLineHeaderBackView *)self.backgroundView setTimeLineDomain:timeLineDomain];
    [self.backgroundView setNeedsDisplay];
}

- (void)segmentSwitch:(UISegmentedControl *)segment {
    
    if (self.switchCallBack) {
        
        XZLHorizontalLineViewDomainStyle style = (XZLHorizontalLineViewDomainStyle)segment.selectedSegmentIndex;
        self.switchCallBack(style);
    }
}

@end
















