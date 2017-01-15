//
//  UITextView+smk_Kit.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextView+SMKLimit.h"
#import "UITextView+smk_Placeholder.h"
@interface UITextView (smk_Kit)

@end
@interface UITextView (smk_inputAccessoryView)

@property (weak, nonatomic) UIResponder *smk_lastFirstResponder;
@property (weak, nonatomic) UIResponder *smk_nextFirstResponder;
@property (assign, nonatomic) BOOL smk_showInputAccessoryView; // 自动展示SMKInputAccessoryView工具条

@end
