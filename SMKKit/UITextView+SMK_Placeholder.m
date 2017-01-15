//
//  UITextView+SMK_Placeholder.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "UITextView+SMK_Placeholder.h"
#import <objc/runtime.h>


static NSString *const kMikeNotificationDidChangeTextView = @"kMikeNotificationDidChangeTextView";

@interface SMKAutoPreferredMaxLayoutWidthLabel : UILabel

@end

@implementation SMKAutoPreferredMaxLayoutWidthLabel

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    self.preferredMaxLayoutWidth = CGRectGetWidth(bounds);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.preferredMaxLayoutWidth = MAX((CGRectGetWidth(self.superview.frame) - CGRectGetMinX(self.frame)), 0);
    
    /**
     *  @brief  第一次调用 [super layoutSubviews] 是为了获得 label 的 frame，而第二次调用是为了改变后更新布局。如果省略第二个调用我们可能会会得到一个 NSInternalInconsistencyException 的错误，因为我们改变了更新约束条件的布局操作，但我们并没有再次触发布局。
     */
    [super layoutSubviews];
}

@end

@interface SMKTextViewPlaceholderHelper : NSObject

@property (nonatomic, weak) UITextView *textView;
- (instancetype)initWithTextView:(UITextView *)textView;

@end


@interface UITextView (nl_PlaceholderHelper)

@property (nonatomic, strong, readonly) UILabel *smk_lblPlaceholder;
@property (nonatomic, strong, readonly) SMKTextViewPlaceholderHelper *smk_placeholderHelper;

@end


@implementation UITextView (SMK_Placeholder)


+ (void)load {
    Method smk_setAttributedText = class_getInstanceMethod(self, @selector(smk_setAttributedText:));
    Method setAttributedText = class_getInstanceMethod(self, @selector(setAttributedText:));
    
    if (setAttributedText && smk_setAttributedText) {
        method_exchangeImplementations(smk_setAttributedText, setAttributedText);
    }
}

- (void)smk_setAttributedText:(NSAttributedString *)attributedText {
    [self smk_setAttributedText:attributedText];
    
    if (self.smk_isDidChangePostNotification) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kMikeNotificationDidChangeTextView object:self];
    }
}

- (void)setSmk_placeholder:(NSString *)smk_placeholder {
    [self.smk_lblPlaceholder setText:smk_placeholder];
    
    [self setNeedsDisplay];
}

- (NSString *)smk_placeholder {
    return [self.smk_lblPlaceholder text];
}

- (void)setSmk_placeholderColor:(UIColor *)smk_placeholderColor {
    [self.smk_lblPlaceholder setTextColor:smk_placeholderColor];
}

- (UIColor *)smk_placeholderColor {
    return [self.smk_lblPlaceholder textColor];
}

- (void)setSmk_placeholderFont:(UIFont *)smk_placeholderFont {
    [self.smk_lblPlaceholder setFont:smk_placeholderFont];
}

- (UIFont *)smk_placeholderFont {
    return [self.smk_lblPlaceholder font];
}

- (void)setSmk_isDidChangePostNotification:(BOOL)smk_isDidChangePostNotification {
    objc_setAssociatedObject(self, @selector(smk_isDidChangePostNotification), @(smk_isDidChangePostNotification), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)smk_isDidChangePostNotification {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end



#pragma mark - nl_PlaceholderHelper
@implementation UITextView (smk_PlaceholderHelper)

- (UILabel *)smk_lblPlaceholder {
    if (!objc_getAssociatedObject(self, _cmd)) {
        UILabel *lblPlaceholder = [[SMKAutoPreferredMaxLayoutWidthLabel alloc] init];
        [lblPlaceholder setTextColor:[UIColor colorWithWhite:0.789 alpha:1.0]];
        [lblPlaceholder setFont:[self font]];
        [lblPlaceholder setNumberOfLines:0];
        
        [self insertSubview:lblPlaceholder atIndex:0];
        
        lblPlaceholder.translatesAutoresizingMaskIntoConstraints = NO;
        NSArray *constraintVs = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[lblPlaceholder]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblPlaceholder)];
        
        NSArray *constraintHs = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-6-[lblPlaceholder]-6-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblPlaceholder)];
        [self addConstraints:constraintHs];
        [self addConstraints:constraintVs];
        
        objc_setAssociatedObject(self, _cmd, lblPlaceholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        if ([self.text length] > 0) {
            [lblPlaceholder setHidden:YES];
        }
        
        [self smk_placeholderHelper];
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (SMKTextViewPlaceholderHelper *)smk_placeholderHelper {
    if (!objc_getAssociatedObject(self, _cmd)) {
        SMKTextViewPlaceholderHelper *helper = [[SMKTextViewPlaceholderHelper alloc] initWithTextView:self];
        objc_setAssociatedObject(self, _cmd, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

@end


#pragma mark - SMKTextViewPlaceholderHelper
@implementation SMKTextViewPlaceholderHelper

- (void)didChange:(NSNotification *)notification {
    [self changePlaceholderHidden];
}

- (void)changePlaceholderHidden {
    self.textView.smk_lblPlaceholder.hidden = self.textView.text.length > 0;
}

- (instancetype)initWithTextView:(UITextView *)textView {
    {
        if (self = [super init]) {
            _textView = textView;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChange:) name:UITextViewTextDidChangeNotification object:textView];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChange:) name:kMikeNotificationDidChangeTextView object:textView];
        }
        return self;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
