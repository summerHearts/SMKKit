//
//  TimeToolHelper.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "TimeToolHelper.h"

@implementation TimeToolHelper

//String转Date
+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format {
    if (format==nil || format.length==0){
        format = @"yyyyMMdd";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:string];
    dateFormatter = nil;
    return date;
}

//Date转String
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format {
    if (format==nil || format.length==0){
        format = @"yyyyMMdd";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:date];
    dateFormatter = nil;
    return dateString;
}

//yyyyMMddhhmmss转任意Format的String
+ (NSString *)stringFromyyyyMMddhhmmss:(NSString *)string format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddhhmmss"];
    NSDate *date = [dateFormatter dateFromString:string];
    if (format==nil || format.length==0){
        format = @"yyyyMMdd";
    }
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:date];
    dateFormatter = nil;
    return dateString;
}

//yyyyMMdd转任意Format的String
+ (NSString *)stringFromyyyyMMdd:(NSString *)string format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [dateFormatter dateFromString:string];
    if (format==nil || format.length==0){
        format = @"yyyyMMdd";
    }
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:date];
    dateFormatter = nil;
    return dateString;
}
//yyyyMMdd转MM-dd
+ (NSString *)stringyyyyMMddToMM_dd:(NSString *)string{

    if (string.length>=8) {
        return [NSString stringWithFormat:@"%@-%@",[string substringWithRange:NSMakeRange(4, 2)],
                                                   [string substringWithRange:NSMakeRange(6, 2)]];
    }else{
        return @"";
    }


}
//yyyyMMdd转yyyy-MM-dd
+ (NSString *)stringyyyyMMddToyyyy_MM_dd:(NSString *)string{
    if (string.length>=8) {
        return [NSString stringWithFormat:@"%@-%@-%@",
                [string substringWithRange:NSMakeRange(0, 4)],
                [string substringWithRange:NSMakeRange(4, 2)],
                [string substringWithRange:NSMakeRange(6, 2)]];
    }else{
        return @"";
    }
}

+ (NSString *)weekNumFromDateString:(NSString *)timeString{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* inputDate = [inputFormatter dateFromString:timeString];
    NSCalendar *calendar= [NSCalendar currentCalendar];
    ;
    NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday) fromDate:inputDate];
    NSString *weekNum = [TimeToolHelper getweek:[components weekday]];
    return weekNum ;
}

+ (NSString*)getweek:(NSInteger)week
{
    NSString*weekStr=nil;
    if(week==1)
    {
        weekStr=@"周日";
    }else if(week==2){
        weekStr=@"周一";
        
    }else if(week==3){
        weekStr=@"周二";
        
    }else if(week==4){
        weekStr=@"周三";
        
    }else if(week==5){
        weekStr=@"周四";
        
    }else if(week==6){
        weekStr=@"周五";
        
    }else if(week==7){
        weekStr=@"周六";
        
    }
    return weekStr;
}


@end
