//
//  NSDate+Extension.m
//
//  Created by liLei on 14-10-15.
//  Copyright (c) 2014年 liLei. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
#pragma mark - 是否为今天
- (BOOL)isToday
{
    NSCalendar *canlendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    // 1.获得当前时间的年、月、日
    NSDateComponents *nowComponents = [canlendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年、月、日
    NSDateComponents *selfComponents = [canlendar components:unit fromDate:self];
    
    return (selfComponents.year == nowComponents.year)
        && (selfComponents.month == nowComponents.month)
        && (selfComponents.day == nowComponents.day);
}

#pragma mark - 是否为昨天
- (BOOL)isYesterday
{
    // 获取当前日期的年月日
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    // 获取self的年月日
    NSDate *selfDate = [self dateWithYMD];
    
    // 计算nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return dateComponents.day == 1;
}

#pragma mark - 返回一个只有年月日的日期
- (NSDate *)dateWithYMD
{
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    dateFmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [dateFmt stringFromDate:self];
    return [dateFmt dateFromString:selfStr];
}

#pragma mark - 是否为今年
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前日期的年
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self时间的年
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    
    return nowComponents.year == selfComponents.year;
}

#pragma mark - 获得与当前日间的差距
- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

#pragma mark - 友好显示日期
+ (NSString *)getFormatTime:(NSString *)dateStr
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dateStr.doubleValue/1000];
    
    // 1.将服务器返回的时间格式化为NSDate
    // 创建时间格式化类
    NSDateFormatter *DateF = [[NSDateFormatter alloc] init];
    DateF.locale = [NSLocale currentLocale];
    // 设置时间格式化字符串
    DateF.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
    // 利用时间格式化类将字符串格式化为NSDate
    NSDate *createdTime = [DateF dateFromString:[DateF stringFromDate:confromTimesp]];
    // 2.判断发布的时间
    if ([createdTime isThisYear]) {
        if ([createdTime isToday]) {
            NSDateComponents *cmps = [createdTime deltaWithNow];
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];;
            } else if (cmps.minute > 1) {
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if ([createdTime isYesterday]) {
            DateF.dateFormat = @"昨天";// @"昨天 HH时mm分";
            return [DateF stringFromDate:createdTime];
        } else {
            DateF.dateFormat = @"MM月dd日"; //@"MM月dd日 HH分mm秒";
            return [DateF stringFromDate:createdTime];
        }
    } else {
        DateF.dateFormat = @"yyyy年MM月dd日";// @"yyyy年MM月dd日 HH时mm分";
        return [DateF stringFromDate:createdTime];
    }
}
+ (NSString *)getContactFormatTime:(NSString *)dateStr
{
    // 1.将服务器返回的时间格式化为NSDate
    // 创建时间格式化类
    NSDateFormatter *DateF = [[NSDateFormatter alloc] init];
    DateF.locale = [NSLocale currentLocale];
    // 设置时间格式化字符串
    DateF.dateFormat = @"yyyy-MM-dd";
    // 利用时间格式化类将字符串格式化为NSDate
    NSDate *createdTime = [DateF dateFromString:dateStr];
    // 2.判断发布的时间
    if ([createdTime isThisYear]) {
        if ([createdTime isToday]) {
            return @"今天";
        } else if ([createdTime isYesterday]) {
//            DateF.dateFormat = @"昨天 HH时mm分";
            return @"昨天";//[DateF stringFromDate:createdTime];
        } else {
            DateF.dateFormat = @"MM月dd日";
            return [DateF stringFromDate:createdTime];
        }
    } else {
        DateF.dateFormat = @"yyyy年MM月dd日";
        return [DateF stringFromDate:createdTime];
    }

}


/**
 *  获取当前时间戳
 */
+ (NSString *)getNowTimeStamp
{
    // 获取当前时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hant"];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS Z";
    NSString *date = [fmt stringFromDate:[NSDate date]];
//    Log(@"OC当前时间:%@",date);
    
    // 将当前时间转时间戳
    NSString *timeStamp = [NSString stringWithFormat:@"%f",[[fmt dateFromString:date] timeIntervalSince1970]* 1000];
    
    // 截取字符串
    NSRange range = [timeStamp rangeOfString:@"."];
    return [timeStamp substringToIndex:range.location];
}

/**
 *  格式化日期(例：yyyy-MM-dd->yyyy年MM月dd)
 */
+ (NSString *)formatterDate1:(NSString *)dateStr
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-hans"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [fmt dateFromString:dateStr];
    fmt.dateFormat = @"MM月dd日";
    
    return [fmt stringFromDate:date];
}

/**
 *  格式化日期(例：yyyy年MM月dd日->yyyyMMdd)
 */
+ (NSString *)formatterDate2:(NSString *)dateStr
{
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    dateFmt.locale = [NSLocale currentLocale];
    dateFmt.dateFormat = @"yyyy年MM月dd日";
    NSDate *date = [dateFmt dateFromString:dateStr];
    dateFmt.dateFormat = @"yyyyMMdd";
    
    return [dateFmt stringFromDate:date];
}

/**
 *  将服务器返回的字符型日期转为NSDate(例：20150412/2015-04-12 00:00:00)
 */
+ (NSDate *)formatterDateString:(NSString *)dateStr
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [NSLocale currentLocale];

    NSDate *date = nil;
    
    fmt.dateFormat = @"yyyyMMdd";
    date = [fmt dateFromString:dateStr];
    
    // 安全判断
    if (!date) {
        
        fmt.dateFormat = @"yyyy-MM-dd";
        date = [fmt dateFromString:dateStr];
    }
    
    if (!date) {
    
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        date = [fmt dateFromString:dateStr];
    }

    return date;
}


//计算  距离现在的时间
+ (NSString *)getUTCFormateDate:(NSString *)newsDate
{
    //          newsDate = @"2015-08-15 11:01";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    
//    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
//    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [NSDate date];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:newsDate.doubleValue/1000];
    
    
    NSTimeInterval time=[current_date timeIntervalSinceDate:confromTimesp];//间隔的秒数
    
//    NSString *confromTimespStr = [dateFormatter stringFromDate:confromTimesp];
//    Log(@"confromTimespStr =  %@",confromTimespStr);
    
    int month=((int)time)/(3600*24*30);
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
    int minute=((int)time)%(3600*24)/60;
//    Log(@"time=%f",(double)time);
    
    NSString *dateContent;
//    NSArray *array = [confromTimespStr componentsSeparatedByString:@" "];

    if(month!=0){
        
        if ([confromTimesp isThisYear])
        {
            [dateFormatter setDateFormat:@"MM月d日"];
        }
        else
        {
            [dateFormatter setDateFormat:@"yyyy年MM月d日"];
        }
        NSString *dateStr = [dateFormatter stringFromDate:confromTimesp];

//        dateContent = [NSString  stringWithFormat:@"%@",[array objectAtIndex:0]];
        return dateStr;

    } else if (days!=0){
        
        if (days ==1) {
            
            dateContent = [NSString stringWithFormat:@"%@",@"昨天"];
            return dateContent;
        }else if (days ==2)
        {
            dateContent = [NSString stringWithFormat:@"%@",@"2天前"];
            return dateContent;
            
        }else
        {
            if ([confromTimesp isThisYear])
            {
                [dateFormatter setDateFormat:@"MM月d日"];
            }
            else
            {
                [dateFormatter setDateFormat:@"yyyy年MM月d日"];
            }
            NSString *dateStr = [dateFormatter stringFromDate:confromTimesp];
            return dateStr;
//            dateContent = [NSString  stringWithFormat:@"%@",[array objectAtIndex:0]];
//            return dateContent;
            
        }
        
    }if(hours!=0){
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"",hours,@"小时前"];
        return dateContent;
        
    }else if(minute !=0){
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"",minute,@"分钟前"];
        return dateContent;
        
    }else
    {
        dateContent =@"刚刚";
        return dateContent;
    }
   
    
    }


+ (NSString *)getYMDFromTimestamp:(NSString *)timestamp
                       isShowYear:(BOOL)show
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue/1000];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ([date isThisYear])
    {
        [dateFormatter setDateFormat:@"MM月d日"];
    }
    else
    {
        [dateFormatter setDateFormat:@"yyyy年MM月d日"];
    }
    
    if (show)
    {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}

/**
 *  格式化时间戳为年月日
 */
//+ (NSString *)getYMDFromTimestamp:(NSString *)timestamp
//{
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp.integerValue/1000];
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    if ([date isThisYear])
//    {
//        [dateFormatter setDateFormat:@"MM月dd日"];
//    }
//    else
//    {
//        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
//    }
//    
//    NSString *dateStr = [dateFormatter stringFromDate:date];
//    
//    return dateStr;
//}

//计算  距离现在的时间 不显示昨天今天 明天 只显示日期和时间
+ (NSString *)getUTCFormateDateJustTime:(NSString *)newsDate
{
    //          newsDate = @"2015-08-15 11:01";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月d日 HH:mm"];
    
    NSTimeInterval timeInterval = [newsDate doubleValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
   if([confromTimesp isToday]){
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:newsDate.doubleValue/1000];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString *dateStr = [dateFormatter stringFromDate:date];
        return dateStr;
    }else{
        
        if ([confromTimesp isThisYear])
        {
            [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
        }
        else
        {
            [dateFormatter setDateFormat:@"yyyy年MM月d日 HH:mm"];
        }
        NSString *dateStr = [dateFormatter stringFromDate:confromTimesp];

        return dateStr;
    }
    
}



@end
