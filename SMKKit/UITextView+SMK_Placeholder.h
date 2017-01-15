//
//  UITextView+SMK_Placeholder.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (SMK_Placeholder)


@property (strong, nonatomic) NSString *smk_placeholder;      // 占位符文字
@property (strong, nonatomic) UIColor  *smk_placeholderColor; // 占位符颜色
@property (strong, nonatomic) UIFont   *smk_placeholderFont;  // 占位符字体


/**
 *  @brief  默认为NO。
 *          UITextView中手动更改text（即：textView.text = text）时，不会主动
 *       发送UITextViewTextDidChangeNotification通知。该通知只有在用户界面上
 *       输入文字时才会发送。本属性如果设置为YES的话，在textView.text = text时，
 *       也主动触发该通知；否则不触发。
 */
@property (assign, nonatomic) BOOL smk_isDidChangePostNotification;
@end
