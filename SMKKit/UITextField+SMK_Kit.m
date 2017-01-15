//
//  UITextField+SMK_Kit.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "UITextField+SMK_Kit.h"
#import "SMKInputAccessoryView.h"
#import <objc/runtime.h>
@implementation UITextField (SMK_Kit)

@end


@interface SMKUITextFieldKitService : NSObject <UITextFieldDelegate>

@property (nonatomic, weak) UIResponder *lastFirstResponder;
@property (nonatomic, weak) UIResponder *nextFirstResponder;
@property (nonatomic, copy) void (^returnKeyBlock)(void);

@end

@implementation SMKUITextFieldKitService

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL result = YES;
    
    if (self.nextFirstResponder && [self.nextFirstResponder canBecomeFirstResponder]) {
        [self.nextFirstResponder becomeFirstResponder];
        result = NO;
    }
    
    if (self.returnKeyBlock) {
        self.returnKeyBlock();
        return NO;
    }
    
    if (result == YES && [textField canResignFirstResponder]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    return result;
}

@end

@implementation UITextField (smk_textFieldDelegate)

- (void)smk_returnKeyBlock:(void (^)(void))returnKeyBlock {
    [self setupKitService];
    
    SMKUITextFieldKitService *service = [self smk_kitService];
    service.returnKeyBlock = returnKeyBlock;
}

- (void)setSmk_nextFirstResponder:(id)smk_nextFirstResponder {
    if (smk_nextFirstResponder) {
        self.returnKeyType = UIReturnKeyNext;
    } else {
        self.returnKeyType = UIReturnKeyDone;
    }
    
    [self setupKitService];
    
    SMKUITextFieldKitService *service = [self smk_kitService];
    [service setNextFirstResponder:smk_nextFirstResponder];
    
    if ([smk_nextFirstResponder respondsToSelector:@selector(smk_lastFirstResponder)]
        && !([smk_nextFirstResponder performSelector:@selector(smk_lastFirstResponder)])) {
        if ([smk_nextFirstResponder respondsToSelector:@selector(setSmk_lastFirstResponder:)]) {
            [smk_nextFirstResponder performSelector:@selector(setSmk_lastFirstResponder:) withObject:self];
        }
    }
}

- (UIResponder *)smk_nextFirstResponder {
    return [[self smk_kitService] nextFirstResponder];
}

- (void)setupKitService {
    SMKUITextFieldKitService *service = [self smk_kitService];
    if (!service) {
        service = [[SMKUITextFieldKitService alloc] init];
        [self setsmk_kitService:service];
    }
    
    self.delegate = service;
}

static void *smk_returnKeyServiceKey = &smk_returnKeyServiceKey;
- (void)setsmk_kitService:(SMKUITextFieldKitService *)service {
    objc_setAssociatedObject(self, smk_returnKeyServiceKey, service, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SMKUITextFieldKitService *)smk_kitService {
    return objc_getAssociatedObject(self, smk_returnKeyServiceKey);
}

@end

@implementation UITextField (smk_inputAccessoryView)

- (void)setSmk_lastFirstResponder:(UIResponder *)smk_lastFirstResponder {
    id delegate = self.delegate;
    [self setupKitService];
    if (delegate) {
        self.delegate = delegate;
    }
    
    SMKUITextFieldKitService *service = [self smk_kitService];
    service.lastFirstResponder = smk_lastFirstResponder;
    
    if ([smk_lastFirstResponder respondsToSelector:@selector(smk_nextFirstResponder)]
        && !([smk_lastFirstResponder performSelector:@selector(smk_nextFirstResponder)])) {
        if ([smk_lastFirstResponder respondsToSelector:@selector(setSmk_nextFirstResponder:)]) {
            [smk_lastFirstResponder performSelector:@selector(setSmk_nextFirstResponder:) withObject:self];
        }
    }
}

- (UIResponder *)smk_lastFirstResponder {
    return [self smk_kitService].lastFirstResponder;
}

static void *smk_showInputAccessoryViewKey = &smk_showInputAccessoryViewKey;
- (void)setSmk_showInputAccessoryView:(BOOL)smk_showInputAccessoryView{
    objc_setAssociatedObject(self, smk_showInputAccessoryViewKey, @(smk_showInputAccessoryView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (smk_showInputAccessoryView) {
        self.inputAccessoryView = [[SMKInputAccessoryView alloc] initWithTargert:self last:self.smk_lastFirstResponder next:self.smk_nextFirstResponder doneBlock:nil];
    } else {
        self.inputAccessoryView = nil;
    }
}

- (BOOL)smk_showInputAccessoryView {
    return [objc_getAssociatedObject(self, smk_showInputAccessoryViewKey) boolValue];
}

@end
