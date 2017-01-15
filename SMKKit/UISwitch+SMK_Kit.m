//
//  UISwitch+SMK_Kit.m
//  SMKKit
//
//  Created by Kenvin on 16/10/9.
//  Copyright © 2016年 上海方创金融股份信息服务有限公司. All rights reserved.
//


#import "UISwitch+SMK_Kit.h"
#import <objc/runtime.h>

@implementation UISwitch (SMK_Kit)

- (void)setChangeBlk:(UISwitchChangeBlock)changeBlk
{
    objc_setAssociatedObject(self, (__bridge void *)self, changeBlk,   OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (!([self.allTargets containsObject:self] && [self actionsForTarget:self forControlEvent:UIControlEventValueChanged])) {
        [self addTarget:self action:@selector(valueChangedInternal:) forControlEvents:UIControlEventValueChanged];
    }
}

- (UISwitchChangeBlock)changeBlk
{
    return objc_getAssociatedObject(self, (__bridge void *)self);
}

- (void)valueChangedInternal:(id)sender
{
    if (self.changeBlk) {
        self.changeBlk(sender);
    }
}
@end
