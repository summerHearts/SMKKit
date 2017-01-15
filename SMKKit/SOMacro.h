//
//  SOMacro.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//
#ifndef SOKit_SOMacro_h
#define SOKit_SOMacro_h


#define SOIFARC __has_feature(objc_arc)

#if __has_feature(objc_arc)
#define SOWEAK                  __weak
#define SOPROPERTYWEAK          weak
#define SOTYPEBLOCK             __weak
#define SORETAIN(obj)           (obj)
#define SORELEASE(obj)          (obj=nil)
#define SORELEASEBLOCK(block)   (block)
#define SOCOPYBLOCK(block)      (block)
#define SOAUTORELEASE(obj)      (obj)
#define SOSUPERDEALLOC()
#else
#define SOWEAK
#define SOPROPERTYWEAK          assign
#define SOTYPEBLOCK             __block
#define SORETAIN(obj)           [obj retain];
#define SORELEASE(obj)          [obj release];obj=nil;
#define SORELEASEBLOCK(block)   Block_release(block)
#define SOCOPYBLOCK(block)      Block_copy(block)
#define SOAUTORELEASE(obj)      [obj autorelease]
#define SOSUPERDEALLOC()        [super dealloc]
#endif


/**
 *  获取AppDelegate
 */
#define APP_DELEGATE (AppDelegate*)[[UIApplication sharedApplication]delegate]

/**
 *  获取standardUserDefaults
 */
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

/**
 *
 */
#define IMAGE_NAMED(_pointer) [UIImage imageNamed:_pointer]

/**
 *  打印日志
 */
#ifdef DEBUG
#   define SOLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define SOLog(...)
#endif


#if __has_feature(objc_arc)
    #define SAFE_ARC_PROP_RETAIN strong
    #define SAFE_ARC_RETAIN(x) (x)
    #define SAFE_ARC_RELEASE(x)
    #define SAFE_ARC_AUTORELEASE(x) (x)
    #define SAFE_ARC_BLOCK_COPY(x) (x)
    #define SAFE_ARC_BLOCK_RELEASE(x)
    #define SAFE_ARC_SUPER_DEALLOC()

#else
    #define SAFE_ARC_PROP_RETAIN retain
    #define SAFE_ARC_RETAIN(x) ([(x) retain])
    #define SAFE_ARC_RELEASE(x) ([(x) release])
    #define SAFE_ARC_AUTORELEASE(x) ([(x) autorelease])
    #define SAFE_ARC_BLOCK_COPY(x) (Block_copy(x))
    #define SAFE_ARC_BLOCK_RELEASE(x) (Block_release(x))
    #define SAFE_ARC_SUPER_DEALLOC() ([super dealloc])
#endif


#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

/**
 *  创建单例
 */
#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)sharedInstance { \
    static className *shared##className = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        shared##className = [[self alloc] init]; \
    }); \
    return shared##className; \
}

/**
 *  弧度角度互转
 */
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

/**
 *  Create a UIColor with r,g,b values between 0.0 and 1.0.
 */

#ifndef RGBCOLOR
#define RGBCOLOR(r,g,b)             [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#endif

#ifndef RGBACOLOR
#define RGBACOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#endif

#ifndef UIColorFromRGB
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                        green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                        blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#endif

#ifndef RANDOMCOLOR
#define RANDOMCOLOR                 [UIColor colorWithHue:((arc4random() % 256 / 256.0))\
                                        saturation:((arc4random() % 128 / 256.0) + 0.5) \
                                        brightness:((arc4random() % 128 / 256.0) + 0.5) alpha:1]
#endif

/**
 *  判断系统版本
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**
 *  UI相关
 */
#define KRScreenWidth ([[UIScreen mainScreen]bounds].size.width)
#define KRScreenHeight ([[UIScreen mainScreen]bounds].size.height)
#define KRScreenBounds ([[UIScreen mainScreen] bounds])
#define KRStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define KROnePixelHeight (1.0/[[UIScreen mainScreen] scale])
#define KRScreenScale  ([[UIScreen mainScreen] scale])
#define KRNavigationBarHeight   44.0
#define KRTabBarHeight  49.0

/**
 *  Device相关
 */
#define KRSystemVersionGreaterThan(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define KRSystemVersionEqualTo(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define KRSystemVersionLessThan(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

/**
 *  Log相关
 */
#define KRLog(s, ...) NSLog( @"[%@ %@] %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd),[NSString stringWithFormat:(s), ##__VA_ARGS__] )

/**
 *  路径相关
 */
#define KRUserDocumentDirectoryPath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject])
#define KRUserCacheDirectoryPath ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject])

#define KRAppVersion    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define KRAppBuildNumber    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
#define KRAppIdentifier ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"])
#define KRAppDisplayName    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
#define KRAppBundleName     ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])

#endif
