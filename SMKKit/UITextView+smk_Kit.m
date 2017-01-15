//
//  UITextView+smk_Kit.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "UITextView+smk_Kit.h"
#import <objc/runtime.h>
#import "SMKInputAccessoryView.h"
@implementation UITextView (smk_Kit)

@end


@implementation UITextView (smk_inputAccessoryView)

- (void)setSmk_nextFirstResponder:(UIResponder *)smk_nextFirstResponder {
    objc_setAssociatedObject(self, sel_getName(@selector(smk_nextFirstResponder)), smk_nextFirstResponder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([smk_nextFirstResponder respondsToSelector:@selector(smk_lastFirstResponder)]
        && ![smk_nextFirstResponder performSelector:@selector(smk_lastFirstResponder)]) {
        if ([smk_nextFirstResponder respondsToSelector:@selector(setSmk_lastFirstResponder:)]) {
            [smk_nextFirstResponder performSelector:@selector(setSmk_lastFirstResponder:) withObject:self];
        }
    }
}

- (UIResponder *)smk_nextFirstResponder {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSmk_lastFirstResponder:(UIResponder *)smk_lastFirstResponder {
    objc_setAssociatedObject(self, sel_getName(@selector(smk_lastFirstResponder)), smk_lastFirstResponder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([smk_lastFirstResponder respondsToSelector:@selector(smk_nextFirstResponder)]
        && ![smk_lastFirstResponder performSelector:@selector(smk_nextFirstResponder)]) {
        if ([smk_lastFirstResponder respondsToSelector:@selector(setSmk_nextFirstResponder:)]) {
            [smk_lastFirstResponder performSelector:@selector(setSmk_nextFirstResponder:) withObject:self];
        }
    }
}

- (UIResponder *)smk_lastFirstResponder {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSmk_showInputAccessoryView:(BOOL)smk_showInputAccessoryView {
    objc_setAssociatedObject(self, @selector(smk_showInputAccessoryView), @(smk_showInputAccessoryView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (smk_showInputAccessoryView) {
        self.inputAccessoryView = [[SMKInputAccessoryView alloc] initWithTargert:self last:self.smk_lastFirstResponder next:self.smk_nextFirstResponder doneBlock:nil];
    } else {
        self.inputAccessoryView = nil;
    }
}

- (BOOL)smk_showInputAccessoryView {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
@end
