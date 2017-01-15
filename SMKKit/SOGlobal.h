//
//  SOGlobal.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIApplication.h>
#import <CoreGraphics/CGBase.h>
#import <CoreGraphics/CGGeometry.h>
#import "SOMacro.h"

/**
 *  @brief  产生随机数
 *
 *  @return 返回(0 ~ 1.0f)
 */
double SORandom();

/**
 *  @brief  屏幕大小
 *
 *  @return 返回UIScreen的size
 */
CGSize SOScreenSize();

/**
 *  @brief  获取当前系统版本
 *
 *  @return 返回系统版本
 */
CGFloat SOSystemVersion(void);

/**
 *  @brief  获得物理分辨同逻辑分辨率的比例，例如:普通屏幕为iPhone3GS为1.0，iPod Touch4、5，iPhone4、4S、5、5S、6均为2，iPhone6Plus为3
 *
 *  @return 返回屏幕缩放
 */
CGFloat SODeviceScale(void);

/**
 *  @brief  判断一个对象是否是字符串NSString及其子类对象，并且是否为空值和值为@“”
 *
 *  @return 返回bool
 */
BOOL SOStringIsNilOrEmpty(NSString *str);

/**
 *  @brief  返回bool值的描述
 *
 *  @return YES返回@"Y"，NO返回@"N"
 */
NSString *NSStringFromBOOL(BOOL b);

/**
 *  @brief  对target执行selector，传递obj
 *
 *  @return 返回执行的返回值
 */
id SOSafePerformSelector(id target, SEL selector, id obj);

/**
 *  @brief  取得当前状态栏的旋转姿态
 *
 *  @return 返回当前状态栏姿态
 */
UIInterfaceOrientation SOStatusBarOrientation();

/**
 *  @brief  判断当前状态栏是否是竖直状态
 *
 *  @return 返回bool
 */
BOOL SOStatusBarIsPortrait();

/**
 *  @brief  判断当前状态栏是否是水平状态
 *
 *  @return 返回bool
 */
BOOL SOStatusBarIsLandscape();

/**
 *  @brief  获取APP的根视图控制器
 *
 *  @return 返回根视图控制器
 */
UIViewController *SOApplicationRootViewController();

/**
 *  @brief  获取APP当前显示的视图控制器
 *
 *  @return 返回当前顶层视图控制器
 */
UIViewController *SOApplicationVisibleViewController();

/**
 *  @brief  获取APP的根试图控制器的第index个子视图
 *
 *  @return 返回视图控制器
 */
UIViewController *SOApplicationTabBarAtIndex(NSUInteger index);

/**
 *  @brief  获取当前视图控制器所在的最底层导航控制器
 *
 *  @return 返回导航控制器
 */
UIViewController *SOViewControllersRootNavigationViewController(UIViewController *viewController);

/**
 *  @brief  返回当前视图控制器
 *
 *  @return 返回当前视图控制器的顶层视图控制器
 */
UIViewController *SOViewControllersVisibleViewController(UIViewController *viewController);

