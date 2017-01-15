//
//  UISwitch+SMK_Kit.h
//  SMKKit
//
//  Created by Kenvin on 16/10/9.
//  Copyright © 2016年 上海方创金融股份信息服务有限公司. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^UISwitchChangeBlock)(id sender);

@interface UISwitch (SMK_Kit)
@property (nonatomic, copy) UISwitchChangeBlock changeBlk;
@end
