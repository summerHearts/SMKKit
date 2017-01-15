//
//  TimeSMKKitHelper.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YEAR @"year"
#define MONTH @"month"
#define DAY @"day"
#define HOUR @"hour"
#define MINUTE @"minute"
#define SECOND @"second"

@interface TimeToolHelper : NSObject
/**
 *  yyyyMMdd转MM-dd
 */+ (NSString *)stringyyyyMMddToMM_dd:(NSString *)string;
/**
 *  yyyyMMdd转yyyy-MM-dd
 */

+ (NSString *)stringyyyyMMddToyyyy_MM_dd:(NSString *)string;

/**
 *  String转Date
 */

+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format;

/**
 *  Date转String
 */

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

/**
 *  yyyyMMddhhmmss转任意Format的String
 */

+ (NSString *)stringFromyyyyMMddhhmmss:(NSString *)string format:(NSString *)format;

/**
 *  yyyyMMdd转任意Format的String
 */

+ (NSString *)stringFromyyyyMMdd:(NSString *)string format:(NSString *)format;
/**
 *  转化星期
 */
+ (NSString *)weekNumFromDateString:(NSString *)timeString;

@end
