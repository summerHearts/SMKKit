//
//  MikeAlertView.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  BlockAlertView: UIAlertView<UIAlertViewDelegate>

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
               cancelButtonWithTitle:(NSString *)cancelTitle
               cancelBlock:(void (^)())cancelblock
               confirmButtonWithTitle:(NSString *)confirmTitle
               confrimBlock:(void (^)())confirmBlock;


@end
