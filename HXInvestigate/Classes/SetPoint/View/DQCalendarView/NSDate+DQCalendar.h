//
//  NSDate+DQCalendar.h
//  HXInvestigate
//
//  Created by 董富强 on 2017/6/2.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DQCalendar)

@property (nonatomic, strong) NSIndexPath *dateIndexPath;

/** 日历视图 数据转换和获取 */
+ (NSCalendar *)gregorianCalendar;
+ (NSLocale *)locale_DQCalendar;

+ (NSDate *)today_DQCalendar;
+ (NSInteger)numberOfMonthsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSInteger)numberOfDaysFromMonth:(NSDate *)fromMonth toMonth:(NSDate *)toMonth;
+ (NSInteger)numberOfDaysInMonth:(NSDate *)date;
+ (NSInteger)numberOfNightsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

- (NSDate *)firstDateOfMonth_DQCalendar;
- (NSDate *)firstDateOfWeek_DQCalendar;
- (NSDate *)lastDateOfMonth_DQCalendar;

- (NSInteger)weekday_DQCalendar;

- (BOOL)isToday_DQCalendar;
- (BOOL)isWeekend_DQCalendar;

//- (BOOL)isEqualToDate:(NSDate *)date toUnitGranularity:(NSCalendarUnit)unit;
- (BOOL)isSameMonthWithDate_DQCalendar:(NSDate *)date;



/** 日历视图 */
+ (NSDate *)dateForFirstDayInSection:(NSInteger)section firstDate:(NSDate *)firstDate;
+ (NSDate *)dateAtIndexPath:(NSIndexPath *)indexPath firstDate:(NSDate *)firstDate;
+ (NSDate *)wholeDateAtIndexPath:(NSIndexPath *)indexPath firstDate:(NSDate *)firstDate;
+ (NSIndexPath *)indexPathAtDate:(NSDate *)date firstDate:(NSDate *)firstDate;
+ (NSIndexPath *)wholeIndexPathAtDate:(NSDate *)date firstDate:(NSDate *)firstDate;




@end
