//
//  DQCalendarHeader.m
//  HXInvestigate
//
//  Created by 董富强 on 2017/6/3.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "DQCalendarHeader.h"

DQCalendarViewConfig DefualtCalendarViewConfig() {
    
    return GetCalendarViewConfig(DQCalendarViewSingleMixMonthStyle,
                                 DQCalendarViewHeadStyleCurrentMonth,
                                 DQCalendarWeekFirstDaySUNStyle,
                                 DQCalendarSelectionModeMutiple);
}

DQCalendarViewConfig GetCalendarViewConfig(DQCalendarViewStyle calendarStyle,
                                           DQCalendarViewHeadStyle headStyle,
                                           DQCalendarWeekFirstDayStyle weekFirstDayStyle,
                                           DQCalendarSelectionModel selecitonModel)
{
    DQCalendarViewConfig config;
    config.calendarStyle = calendarStyle;
    config.headStyle = headStyle;
    config.weekFirstDayStyle = weekFirstDayStyle;
    config.selecitonModel = selecitonModel;
    
    return config;
}
