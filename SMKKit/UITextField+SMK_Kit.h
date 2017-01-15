//
//  UITextField+SMK_Kit.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+SMKLimit.h"
#import "SMKInputAccessoryView.h"
@interface UITextField (SMK_Kit)

@end
/**
 *  @brief  UITextFieldDelegate的快捷方法  注意：当你自己设置了UITextField的delegate时，这里面的内容都将失效
 */
@interface UITextField (smk_textFieldDelegate)

/**
 *  @brief  当点击return key后的下一个获取键盘焦点的对象
 */
@property (weak, nonatomic) UIResponder *smk_nextFirstResponder;

/**
 *  @brief  当点击return key后调用的block
 *
 *  @param returnKeyBlock 点击return key后调用的block
 */
- (void)smk_returnKeyBlock:(void(^)(void))returnKeyBlock;

@end

@interface UITextField (smk_inputAccessoryView)

@property (weak, nonatomic) UIResponder *smk_lastFirstResponder;
@property (assign, nonatomic) BOOL smk_showInputAccessoryView; // 自动展示NLInputAccessoryView工具条

@end
