//
//  UIButton+CountDown.h
//  SMKKit
//
//  Created by Kenvin on 16/1/10.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^SMKButtonActionBlock)();


@interface UIButton (SMK_Kit)

/**
 *  @brief  给按钮加上click事件
 *
 *  @param action 当按钮click时要执行的block。
 */
- (void)smk_handleClickBlock:(SMKButtonActionBlock)action;

/**
 *  @brief 给按钮加上block事件
 *
 *  @param events 要响应的事件
 *  @param action 当events触发时，要执行的block
 */
- (void)smk_handleControlEvents:(UIControlEvents)events withBlock:(SMKButtonActionBlock)action;
/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param mColor   还没倒计时的颜色
 *  @param color    倒计时中的颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

@end
