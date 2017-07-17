//
//  DQCalendarHeader.h
//  HXInvestigate
//
//  Created by 董富强 on 2017/6/3.
//  Copyright © 2017年 董富强. All rights reserved.
//

#ifndef DQCalendarHeader_h
#define DQCalendarHeader_h

#import "NSDate+DQCalendar.h"

typedef NS_OPTIONS(NSInteger, DQCalendarViewStyle) {
    DQCalendarViewSingleMixMonthStyle = 0,
    DQCalendarViewSingleMonthStyle = 1,
    DQCalendarViewMultiMonthStyle = 2,
};

typedef NS_OPTIONS(NSInteger, DQCalendarViewHeadStyle) {
    
    DQCalendarViewHeadStyleCurrentMonth = 0,
    DQCalendarViewHeadStyleCurrentWeek,
};

typedef enum : NSUInteger {
    
    DQCalendarWeekFirstDaySUNStyle=7,//7 == 周日
    DQCalendarWeekFirstDayMONStyle=1,//1 == 周一
    DQCalendarWeekFirstDayTUEStyle=2,//2 == 周二
    DQCalendarWeekFirstDayWEDStyle=3,//3 == 周三
    DQCalendarWeekFirstDayTHUStyle=4,//4 == 周四
    DQCalendarWeekFirstDayFRIStyle=5,//5 == 周五
    DQCalendarWeekFirstDaySATStyle=6,//6 == 周六
} DQCalendarWeekFirstDayStyle;

typedef NS_OPTIONS(NSInteger, DQCalendarSelectionModel) {
    
    DQCalendarSelectionModeDisable = 0,    // Can not select
    DQCalendarSelectionModeSingle,         // Single selection mode
    DQCalendarSelectionModeMutiple,        // Mutile selection mode
};

struct DQCalendarViewConfig {
    
    DQCalendarViewStyle calendarStyle;
    DQCalendarViewHeadStyle headStyle;
    DQCalendarWeekFirstDayStyle weekFirstDayStyle;
    DQCalendarSelectionModel selecitonModel;
    
};
typedef struct DQCalendarViewConfig DQCalendarViewConfig;


DQCalendarViewConfig DefualtCalendarViewConfig();
DQCalendarViewConfig GetCalendarViewConfig(DQCalendarViewStyle calendarStyle,
                                           DQCalendarViewHeadStyle headStyle,
                                           DQCalendarWeekFirstDayStyle weekFirstDayStyle,
                                           DQCalendarSelectionModel selecitonModel);

#endif /* DQCalendarHeader_h */





















