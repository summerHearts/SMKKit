//
//  UIBarButtonItem+Blocks.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "UIBarButtonItem+Blocks.h"
#import <objc/runtime.h>

static const void *SMKBarButtonItemBlockKey = &SMKBarButtonItemBlockKey;

@interface UIBarButtonItem (BlocksKitPrivate)

- (void)smk_handleAction:(UIBarButtonItem *)sender;

@end

@implementation UIBarButtonItem (Blocks)

- (id)smk_initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem handler:(void (^)(id sender))action
{
    self = [self initWithBarButtonSystemItem:systemItem target:self action:@selector(smk_handleAction:)];
    if (!self) return nil;
    
    objc_setAssociatedObject(self, SMKBarButtonItemBlockKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (id)smk_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action
{
    self = [self initWithImage:image style:style target:self action:@selector(smk_handleAction:)];
    if (!self) return nil;
    
    objc_setAssociatedObject(self, SMKBarButtonItemBlockKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (id)smk_initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action
{
    self = [self initWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:self action:@selector(smk_handleAction:)];
    if (!self) return nil;
    
    objc_setAssociatedObject(self, SMKBarButtonItemBlockKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (id)smk_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action
{
    self = [self initWithTitle:title style:style target:self action:@selector(smk_handleAction:)];
    if (!self) return nil;
    
    objc_setAssociatedObject(self, SMKBarButtonItemBlockKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (void)smk_handleAction:(UIBarButtonItem *)sender
{
    void (^block)(id) = objc_getAssociatedObject(self, SMKBarButtonItemBlockKey);
    if (block) block(sender);
}

@end
