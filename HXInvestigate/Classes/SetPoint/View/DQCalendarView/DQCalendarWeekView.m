//
//  DQCalendarWeekView.m
//  HXInvestigate
//
//  Created by 董富强 on 2017/6/2.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "DQCalendarWeekView.h"

@interface DQCalendarWeekView ()

@property (nonatomic, strong) NSMutableArray *adjustedSymbols;
@property (nonatomic, strong) NSMutableArray *weekDayLabels;

@end
@implementation DQCalendarWeekView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initWeekData];
        [self createWeekDayLabels];
    }
    return self;
}

- (void)initWeekData {
    
    NSCalendar *calendar = [NSDate gregorianCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.calendar = calendar;
    
    NSArray *weekdaySymbols = [dateFormatter veryShortWeekdaySymbols];
    
    NSMutableArray *adjustedSymbols = [NSMutableArray arrayWithArray:weekdaySymbols];
    
    NSInteger cutCount = 1 - calendar.firstWeekday + weekdaySymbols.count + 1;
    for (NSInteger index = 0; index < cutCount; index++) {
        
        NSString *lastObject = [adjustedSymbols lastObject];
        [adjustedSymbols removeLastObject];
        [adjustedSymbols insertObject:lastObject atIndex:0];
    }
    self.adjustedSymbols = adjustedSymbols;
}

- (void)createWeekDayLabels {
    
    self.weekDayLabels = [NSMutableArray array];
    self.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0 ; i < self.adjustedSymbols.count; i++) {
        
        CGFloat w = CGRectGetWidth(self.frame) / 7;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(w * i, 0, w, CGRectGetHeight(self.frame))];
        label.textColor = [UIColor darkTextColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15];
        label.text = [self.adjustedSymbols[i] uppercaseString];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [self.weekDayLabels addObject:label];
    }
    
    
    if (!self.bottomLine) {
        
//        self.bottomLine = [CALayer layer];
//        self.bottomLine.frame =
//        CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5);
//        self.bottomLine.backgroundColor =
//        [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:233.0/255.0 alpha:1.0].CGColor;
//        [self.layer addSublayer:self.bottomLine];
    }
}

- (void)setDelegate:(id<DQCalendarWeekViewDelegate>)delegate {
    
    _delegate = delegate;
    [self reloadWeekView];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    
    _contentInsets = contentInsets;
    [self layoutSubviews];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat width = (self.frame.size.width - _contentInsets.left - _contentInsets.right) / 7;
    for (int i = 0; i < _weekDayLabels.count; i++) {
        
        UILabel *label = [_weekDayLabels objectAtIndex:i];
        label.frame = CGRectMake(_contentInsets.left + i * width, 0, width, CGRectGetHeight(self.frame));
    }
    self.bottomLine.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5);
}

- (void)reloadWeekView {
    
    for (int i = 0; i < self.adjustedSymbols.count; i++) {
        
        UILabel *label = [_weekDayLabels objectAtIndex:i];
        if (label && _delegate &&
            [_delegate respondsToSelector:@selector(calendarWeekView:configureWeekDayLabel:atWeekDay:)]) {
            
            [_delegate calendarWeekView:self configureWeekDayLabel:label atWeekDay:i];
        }
    }
}

@end
























