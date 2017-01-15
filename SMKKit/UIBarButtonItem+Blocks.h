//
//  UIBarButtonItem+Blocks.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Blocks)

/**
 *  系统barButtonItem 的点击事件
 *
 *  @param systemItem 系统barButtonItem
 *  @param action     点击回调事件
 *
 *  @return
 */
- (id)smk_initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem handler:(void (^)(id sender))action NS_REPLACES_RECEIVER;

/**
 *  返回一个带文字的title
 *
 *  @param title  显示的文字
 *  @param style  样式
 *  @param action 点击回调事件
 *
 *  @return
 */
- (id)smk_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action NS_REPLACES_RECEIVER;

- (id)smk_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action NS_REPLACES_RECEIVER;

- (id)smk_initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action NS_REPLACES_RECEIVER NS_AVAILABLE_IOS(5_0);


@end
