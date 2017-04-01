//
//  NSDate+Extension.h
//
//  Created by liLei on 14-10-15.
//  Copyright (c) 2014年 liLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;
/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;
/**
 *  获得与当前日间的差距
 */
- (NSDateComponents *)deltaWithNow;

/**
 *  友好显示日期
 */
+ (NSString *)getFormatTime:(NSString *)dateStr;
+ (NSString *)getContactFormatTime:(NSString *)dateStr;

/**
 *  获取当前的时间戳
 */
+ (NSString *)getNowTimeStamp;

/**
 *  格式化日期(例：yyyy-MM-dd->yyyy年MM月dd)
 */
+ (NSString *)formatterDate1:(NSString *)dateStr;

/**
 *  格式化日期(例：yyyy年MM月dd日->yyyyMMdd)
 */
+ (NSString *)formatterDate2:(NSString *)dateStr;

/**
 *  将服务器返回的字符型日期转为NSDate(例：20150412/2015-04-12 00:00:00)
 */
+ (NSDate *)formatterDateString:(NSString *)dateStr;


+ (NSString *)getUTCFormateDate:(NSString *)newsDate;

+ (NSString *)getYMDFromTimestamp:(NSString *)timestamp
                       isShowYear:(BOOL)show;
+ (NSString *)getUTCFormateDateJustTime:(NSString *)newsDate;
@end
