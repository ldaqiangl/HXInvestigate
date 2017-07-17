//
//  NSDate+DQCalendar.m
//  HXInvestigate
//
//  Created by 董富强 on 2017/6/2.
//  Copyright © 2017年 董富强. All rights reserved.
//

#import "NSDate+DQCalendar.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

const char * const dqIndexPathStoreKey = "dq.calendar.indexpath";
const char * const dqCalendarStoreKey = "dq.calendar";
const char * const dqLocaleStoreKey = "dq.locale";

@implementation NSDate (DQCalendar)

#pragma mark -
+ (void)setGregorianCalendar:(NSCalendar *)gregorianCalendar
{
    objc_setAssociatedObject(self, dqCalendarStoreKey, gregorianCalendar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSCalendar *)gregorianCalendar
{
    NSCalendar *cal = objc_getAssociatedObject(self, dqCalendarStoreKey);
    if (nil == cal) {
        cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [cal setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        [cal setLocale:[self locale_DQCalendar]];
        [self setGregorianCalendar:cal];
    }
    return cal;
}

+ (void)setLocal_DQCalendar:(NSLocale *)locale_DQCalendar
{
    objc_setAssociatedObject(self, dqLocaleStoreKey, locale_DQCalendar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSLocale *)locale_DQCalendar
{
    NSLocale *locale  = objc_getAssociatedObject(self, dqLocaleStoreKey);
    if (nil == locale) {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
        [self setLocal_DQCalendar:locale];
    }
    return locale;
}

- (void)setDateIndexPath:(NSIndexPath *)dateIndexPath {
    
    objc_setAssociatedObject(self, dqIndexPathStoreKey, dateIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)dateIndexPath {
    
    NSIndexPath *dateIndexPath = objc_getAssociatedObject(self, dqIndexPathStoreKey);
    return dateIndexPath;
}

#pragma mark -

+ (NSDate *)today_DQCalendar {
    
    NSDate *sourceDate = [NSDate date];
    
    NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    return [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
}

+ (NSInteger)numberOfMonthsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    
    NSCalendar *calendar = [self gregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:[fromDate firstDateOfMonth_DQCalendar] toDate:[toDate lastDateOfMonth_DQCalendar] options:NSCalendarMatchStrictly];
    // 2016.9.16 - 2016.3.16 = 5  if use [fromDate firstDateOfMonth] and [toDate lastDateOfMonth], the result is 6. ok
    // 2017.3.16 - 2016.3.16 = 12
    return components.month + 1;
}

+ (NSInteger)numberOfDaysFromMonth:(NSDate *)fromMonth toMonth:(NSDate *)toMonth {
    
    NSCalendar *calendar = [self gregorianCalendar];
    NSDate *firstDate = [fromMonth firstDateOfMonth_DQCalendar];
    NSDate *lastDate = [toMonth lastDateOfMonth_DQCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:firstDate toDate:lastDate options:NSCalendarMatchStrictly];
    return components.day + 1;
}

+ (NSInteger)numberOfDaysInMonth:(NSDate *)date {
    NSCalendar *calendar = [self gregorianCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

+ (NSInteger)numberOfNightsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlag = NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlag fromDate:fromDate toDate:toDate options:0];
    NSInteger days = [components day];
    return days;
}

#pragma mark -
- (NSDate *)firstDateOfMonth_DQCalendar {
    
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    components.day = 1;
    return [calendar dateFromComponents:components];
}

- (NSDate *)firstDateOfWeek_DQCalendar {
    
    NSInteger weekDay = self.weekday_DQCalendar;
    
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:self];
    components.day = components.day - weekDay + 1;
    return [calendar dateFromComponents:components];
}

- (NSDate *)lastDateOfMonth_DQCalendar {
    
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    components.month = components.month + 1;
    components.day = 0;
    return [calendar dateFromComponents:components];
}

- (NSInteger)weekday_DQCalendar {
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *compoents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return compoents.weekday;
}

- (BOOL)isToday_DQCalendar {
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *otherDay = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    if([today day] == [otherDay day] &&
       [today month] == [otherDay month] &&
       [today year] == [otherDay year] &&
       [today era] == [otherDay era]) {
        return YES;
    }
    return NO;
}

- (BOOL)isWeekend_DQCalendar {
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSRange weekdayRange = [calendar maximumRangeOfUnit:NSCalendarUnitWeekday];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSUInteger weekdayOfDate = [components weekday];
    
    if (weekdayOfDate == weekdayRange.location || weekdayOfDate == weekdayRange.length) {
        //the date falls somewhere on the first or last days of the week
        return YES;
    }
    return NO;
}

- (BOOL)isSameMonthWithDate_DQCalendar:(NSDate *)date {
    
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:self];
    NSDateComponents *toComponents = [calendar components:NSCalendarUnitMonth fromDate:date];
    return components.month == toComponents.month;
}






+ (NSDate *)dateForFirstDayInSection:(NSInteger)section firstDate:(NSDate *)firstDate {
    
    NSCalendar *calendar = [NSDate gregorianCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = section;
    return [calendar dateByAddingComponents:dateComponents toDate:[firstDate firstDateOfMonth_DQCalendar] options:0];
}

+ (NSDate *)dateAtIndexPath:(NSIndexPath *)indexPath firstDate:(NSDate *)firstDate {
    
    NSDate *firstDay = [NSDate  dateForFirstDayInSection:indexPath.section firstDate:firstDate];
    NSInteger weekDay = [firstDay weekday_DQCalendar];
    NSDate *dateToReturn = nil;
    
    if (indexPath.row < (weekDay - 1) || indexPath.row > weekDay - 1 + [NSDate numberOfDaysInMonth:firstDay] - 1) {
        dateToReturn = nil;
    } else {
        NSCalendar *calendar = [NSDate gregorianCalendar];
        
        NSDateComponents *components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:firstDay];
        [components setDay:indexPath.row - (weekDay - 1)];
        [components setMonth:indexPath.section];
        dateToReturn = [calendar dateByAddingComponents:components toDate:[firstDate firstDateOfMonth_DQCalendar] options:0];
    }
    return dateToReturn;
}

+ (NSDate *)wholeDateAtIndexPath:(NSIndexPath *)indexPath firstDate:(NSDate *)firstDate {
    
    NSDate *firstDay = [NSDate dateForFirstDayInSection:indexPath.section firstDate:firstDate];
    NSInteger weekDay = [firstDay weekday_DQCalendar];
    NSDate *dateToReturn = nil;
    
    NSCalendar *calendar = [NSDate gregorianCalendar];
    NSDateComponents *components =
    [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:firstDay];
    
    NSInteger thisMonthDaysNum = [NSDate numberOfDaysInMonth:firstDay];
    if (indexPath.row < (weekDay - 1)) {
        
        components.day = components.day - (weekDay - indexPath.row);
    } else if (indexPath.row > weekDay - 1 + thisMonthDaysNum - 1) {
        
        [components setDay:indexPath.row - (weekDay - 1)];
    } else {
        
        [components setDay:indexPath.row - (weekDay - 1)];
    }
    
    [components setMonth:indexPath.section];
    dateToReturn = [calendar dateByAddingComponents:components toDate:[firstDate firstDateOfMonth_DQCalendar] options:0];
    return dateToReturn;
}


+ (NSIndexPath *)indexPathAtDate:(NSDate *)date firstDate:(NSDate *)firstDate {
    
    NSCalendar *calendar = [NSDate gregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    NSDateComponents *firstDateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:firstDate];
    
    NSDate *firstDateOfMonth = [date firstDateOfMonth_DQCalendar];
    NSDateComponents *firstDateOfMonthComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDateOfMonth];
    
    NSInteger section = (components.year - firstDateComponents.year) * 12 + components.month - firstDateComponents.month;
    NSInteger index = firstDateOfMonthComponents.weekday + components.day - 2;
    
    return [NSIndexPath indexPathForItem:index inSection:section];
}

+ (NSIndexPath *)wholeIndexPathAtDate:(NSDate *)date firstDate:(NSDate *)firstDate {
    
    NSCalendar *calendar = [NSDate gregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    NSDateComponents *firstDateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:firstDate];
    
    NSDate *firstDateOfMonth = [date firstDateOfMonth_DQCalendar];
    NSDateComponents *firstDateOfMonthComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDateOfMonth];
    
    NSInteger section = (components.year - firstDateComponents.year) * 12 + components.month - firstDateComponents.month;
    NSInteger index = firstDateOfMonthComponents.weekday + components.day - 2;
    
    return [NSIndexPath indexPathForItem:index inSection:section];
}

@end





