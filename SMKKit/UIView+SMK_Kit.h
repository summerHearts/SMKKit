//
//  UIView+SMK_Kit.h
//  SMKKit
//
//  Created by Kenvin on 15/7/7.
//  Copyright (c) 2015年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);


@interface UIView(SMK_Kit)

@property (copy, nonatomic) BOOL (^smk_pointInsideBlock)(CGPoint point, UIEvent *event);

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGFloat centerY;

@property (nonatomic, readonly) CGFloat ttScreenX;

@property (nonatomic, readonly) CGFloat ttScreenY;

@property (nonatomic, readonly) CGFloat screenViewX;

@property (nonatomic, readonly) CGFloat screenViewY;

@property (nonatomic, readonly) CGRect screenFrame;

@property (nonatomic) CGPoint origin;

@property (nonatomic) CGSize size;

- (void)removeAllSubviews;


/**
 *  @brief  当前本view下的获取了键盘焦点的view
 *
 *  @return 如果有subView获取了焦点，返回该view  否则返回YES
 */
- (UIView *)smk_firstResponder;

@end

@interface UIView (Animation)

// Moves
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

// Transforms
- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;
- (void)spinClockwise:(float)secs;
- (void)spinCounterClockwise:(float)secs;

// Transitions
- (void)curlDown:(float)secs;
- (void)curlUpAndAway:(float)secs;
- (void)drainAway:(float)secs;

// Effects
- (void)changeAlpha:(float)newAlpha secs:(float)secs;
- (void)pulse:(float)secs continuously:(BOOL)continuously;

@end

extern CGFloat const SODataStateDefaultHeight;

typedef NS_OPTIONS(NSUInteger, SOViewDataState) {
    SOViewDataStateNormal  = 0,    //正常显示
    SOViewDataStateNoData,         //没有数据
    SOViewDataStateLoading         //正在加载
};

@interface UIView(DataState)

//相对位置，默认(0.5f, 0.5f)
- (CGPoint)dataStatePosition;
- (void)setDataStatePosition:(CGPoint)position;

- (CGFloat)dataStateImageContentOffset;
- (void)setDataStateImageContentOffset:(CGFloat)offset;

- (UIFont *)dataStateWaringFont;
- (void)setDataStateWaringFont:(UIFont *)font;

- (NSString *)dataStateWaring;
- (void)setDataStateWaring:(NSString *)waring;

- (UIImage *)dataStateWaringImage;
- (void)setDataStateWaringImage:(UIImage *)image;

- (UIColor *)dataStateLoadingViewColor;
- (void)setDataStateLoadingViewColor:(UIColor *)color;

- (SOViewDataState)dataState;
- (void)setDataState:(SOViewDataState)dataState;

- (void)SOStateViewLayoutSubviews;

@end

@interface UIView(SMKDebug)
- (void)SMKDebugWithBorderColor:(UIColor *)color borderWidth:(CGFloat)width;
@end

@interface UIView(SMKAction)

- (UITapGestureRecognizer *)addTarget:(id)object action:(SEL)action;
- (void)removeObject:(id)object action:(SEL)action;
- (UILongPressGestureRecognizer *)addLongPressTarget:(id)object action:(SEL)action;
- (void)removeLongPressTarget:(id)object ation:(SEL)action;

@end

static char kActionHandlerTapBlockKey;
static char kActionHandlerLongPressBlockKey;


@interface UIView (SMK_BlockGesture)

- (void)smk_addTapActionWithBlock:(GestureActionBlock)block;

- (void)smk_addLongPressActionWithBlock:(GestureActionBlock)block;

@end


@interface UIView (SMKLayer)

@property (nonatomic, assign) CGFloat round;   // view round
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) UIColor *borderColor;

@property (nonatomic, assign) UIColor *smk_shadowColor;
@property (nonatomic, assign) CGFloat smk_shadowRadius;
@property (assign, nonatomic) CGSize  smk_shadowOffset;
@property (assign, nonatomic) CGFloat smk_shadowOpacity;

- (void)setBorderWith:(CGFloat)width color:(UIColor *)color;

- (void)smk_setBorderWith:(CGFloat)width color:(UIColor *)color top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right;
- (void)smk_setTopBorderWith:(CGFloat)width color:(UIColor *)color;
- (void)smk_setLeftBorderWith:(CGFloat)width color:(UIColor *)color;
- (void)smk_setBottomBorderWith:(CGFloat)width color:(UIColor *)color;
- (void)smk_setRightBorderWith:(CGFloat)width color:(UIColor *)color;
@end


@interface UIView (SMK_Image)

/**
 *  @brief  对本view截图
 *
 *  @return 截图后的UIImage
 */
- (UIImage *)smk_screenshot;

@end

/**
 *  @author Jake
 *
 *  @brief 解决圆角卡顿状况
 */
@interface UIView (UIViewRoundCorner)

/**
 *  添加圆角通过纯色背景
 *
 *  @param color  颜色
 *  @param radius 圆角半径
 */
- (void)addRoundCornerWithBGColor:(UIColor *)color andRadius:(CGFloat)radius;

/**
 *  添加圆角通过图片image
 *
 *  @param image  图片
 *  @param radius 圆角半径
 */
- (void)addRoundCornerWithBGImage:(UIImage *)image andRadius:(CGFloat)radius;

@end
