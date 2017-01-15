//
//  SMKImageButton.h
//  SMKKit
//
//  Created by Jakub Truhlar on 10.05.15.
//  Copyright (c) 2015 Jakub Truhlar. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat SMKImageButtonIconHeightDefault = 0.0;
static CGFloat SMKImageButtonIconOffsetYNone = 0.0;

@interface SMKImageButton : UIButton

typedef enum {
    SMKImageButtonPaddingNone = 0,
    SMKImageButtonPaddingSmall,
    SMKImageButtonPaddingMedium,
    SMKImageButtonPaddingBig
} SMKImageButtonPadding;

typedef enum {
    SMKImageButtonIconSideLeft = 0,
    SMKImageButtonIconSideRight
} SMKImageButtonIconSide;


@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) UIColor *iconColor;

@property (nonatomic, strong) UIColor *bgColor;

@property (nonatomic, assign) SMKImageButtonPadding padding;

@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, assign) SMKImageButtonIconSide iconSide;

@property (nonatomic, assign) CGFloat highlightAlpha;

@property (nonatomic, assign) CGFloat disableAlpha;

@property (nonatomic, assign) BOOL touchEffectEnabled;

- (void)createTitle:(NSString *)titleText withIcon:(UIImage *)iconImage font:(UIFont *)titleFont iconHeight:(CGFloat)iconHeight  backgroundColor:(UIColor *)color iconOffsetY:(CGFloat)iconOffsetY ;

- (void)createTitle:(NSString *)titleText withIcon:(UIImage *)iconImage font:(UIFont *)titleFont color:(UIColor *)color iconOffsetY:(CGFloat)iconOffsetY ;

@end
