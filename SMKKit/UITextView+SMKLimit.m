//
//  UITextView+SMKLimit.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "UITextView+SMKLimit.h"
#import <objc/runtime.h>



@interface SMK_PrivateUITextViewMaxLengthHelper : NSObject

@property (nonatomic, assign) NSUInteger maxLength;
@property (nonatomic, weak)   UITextView *textView;
- (instancetype)initWithTextView:(UITextView *)textView maxLength:(NSUInteger)maxLength;

@end


@interface UITextView (SMK_PrivateMaxLengthHelper)

@property (nonatomic, strong) SMK_PrivateUITextViewMaxLengthHelper *smk_maxLengthHelper;
@end

@implementation UITextView (SMKLimit)

static void *smkUITextViewLimitMaxLengthKey = &smkUITextViewLimitMaxLengthKey;

- (void)setSmk_maxLength:(NSUInteger)smk_maxLength {
    objc_setAssociatedObject(self, smkUITextViewLimitMaxLengthKey, @(smk_maxLength), OBJC_ASSOCIATION_COPY);
    self.smk_maxLengthHelper.maxLength = smk_maxLength;
}

- (NSUInteger)smk_maxLength {
    return [objc_getAssociatedObject(self, smkUITextViewLimitMaxLengthKey) unsignedIntegerValue];
}

@end


@implementation UITextView (SMK_PrivateMaxLengthHelper)

static void *smkSMK_maxLengthHelper = &smkSMK_maxLengthHelper;
- (void)setSmk_maxLengthHelper:(SMK_PrivateUITextViewMaxLengthHelper *)smk_maxLengthHelper {
    objc_setAssociatedObject(self, smkSMK_maxLengthHelper, smk_maxLengthHelper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SMK_PrivateUITextViewMaxLengthHelper *)smk_maxLengthHelper {
    SMK_PrivateUITextViewMaxLengthHelper *helper = objc_getAssociatedObject(self, smkSMK_maxLengthHelper);
    if (!helper) {
        helper = [[SMK_PrivateUITextViewMaxLengthHelper alloc] initWithTextView:self maxLength:self.smk_maxLength];
        [self setSmk_maxLengthHelper:helper];
    }
    
    return helper;
}

@end

@implementation SMK_PrivateUITextViewMaxLengthHelper

- (instancetype)initWithTextView:(UITextView *)textView maxLength:(NSUInteger)maxLength {
    if (self = [super init]) {
        _textView = textView;
        _maxLength = maxLength;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_smk_valueChanged:) name:UITextViewTextDidBeginEditingNotification object:textView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_smk_valueChanged:) name:UITextViewTextDidChangeNotification object:textView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_smk_valueChanged:) name:UITextViewTextDidEndEditingNotification object:textView];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - private
- (void)_smk_valueChanged:(NSNotification *)notification {
    UITextView *textView = [notification object];
    if (textView != self.textView) {
        return;
    }
    
    if (self.maxLength == 0) {
        return;
    }
    
    NSUInteger currentLength = [textView.text length];
    if (currentLength <= self.maxLength) {
        return;
    }
    
    NSString *subString = [textView.text substringToIndex:self.maxLength];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textView.text = subString;
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    });
}

@end
