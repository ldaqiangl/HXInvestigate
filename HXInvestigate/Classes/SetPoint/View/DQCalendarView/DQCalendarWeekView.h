//
//  DQCalendarWeekView.h
//  HXInvestigate
//
//  Created by 董富强 on 2017/6/2.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQCalendarHeader.h"

@class DQCalendarWeekView;
@protocol DQCalendarWeekViewDelegate <NSObject>

@optional

- (void)calendarWeekView:(DQCalendarWeekView *)weekView
   configureWeekDayLabel:(UILabel *)dayLabel
               atWeekDay:(NSInteger)weekDay;

@end


@interface DQCalendarWeekView : UIView

@property (nonatomic, weak) id<DQCalendarWeekViewDelegate> delegate;
@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, strong) CALayer *bottomLine;

- (void)reloadWeekView;

@end

