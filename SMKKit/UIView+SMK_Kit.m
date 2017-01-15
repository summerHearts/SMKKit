//
//  UIView+SMK_Kit.m
//  SMKKit
//
//  Created by Kenvin on 15/7/7.
//  Copyright (c) 2015年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "UIView+SMK_Kit.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "SOGlobal.h"
#import "NSString+SOAdditions.h"
#import "NSObject+SOObject.h"

@implementation UIView(SMK_Kit)

@dynamic size;


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)left {
    return self.frame.origin.x;
}


- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (CGFloat)centerX {
    return self.center.x;
}


- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


- (CGFloat)centerY {
    return self.center.y;
}


- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


- (CGFloat)width {
    return self.frame.size.width;
}


- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (CGFloat)ttScreenX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}


- (CGFloat)ttScreenY {
    CGFloat y = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

- (CGFloat)screenViewX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}


+ (void)load {
    Method pointInsideMethod = class_getInstanceMethod(self, @selector(pointInside:withEvent:));
    Method smk_pointInsideMethod = class_getInstanceMethod(self, @selector(smk_pointInside:withEvent:));
    
    if (pointInsideMethod && smk_pointInsideMethod) {
        method_exchangeImplementations(pointInsideMethod, smk_pointInsideMethod);
    }
}

- (BOOL)smk_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.smk_pointInsideBlock) {
        return self.smk_pointInsideBlock(point, event);
    }
    
    return [self smk_pointInside:point withEvent:event];
}

static void *smk_pointInsideBlockKey = &smk_pointInsideBlockKey;
- (void)setSmk_pointInsideBlock:(BOOL (^)(CGPoint, UIEvent *))smk_pointInsideBlock {
    objc_setAssociatedObject(self, smk_pointInsideBlockKey, smk_pointInsideBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL (^)(CGPoint, UIEvent *))smk_pointInsideBlock {
    return objc_getAssociatedObject(self, smk_pointInsideBlockKey);
}

- (UIView *)smk_firstResponder {
    if ([self isFirstResponder]) return self;
    
    for (UIView *subView in [self subviews]) {
        UIView *firstResponder = [subView smk_firstResponder];
        if (firstResponder) return firstResponder;
    }
    
    return nil;
}


@end

@implementation UIView(Animation)

#pragma mark - Moves

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option {
    [self moveTo:destination duration:secs option:option delegate:nil callback:nil];
}

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.frame = CGRectMake(destination.x,destination.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                             SOSafePerformSelector(delegate, method, nil);
                         }
                     }];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack {
    [self raceTo:destination withSnapBack:withSnapBack delegate:nil callback:nil];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method {
    CGPoint stopPoint = destination;
    if (withSnapBack) {
        // Determine our stop point, from which we will "snap back" to the final destination
        int diffx = destination.x - self.frame.origin.x;
        int diffy = destination.y - self.frame.origin.y;
        if (diffx < 0) {
            // Destination is to the left of current position
            stopPoint.x -= 10.0;
        } else if (diffx > 0) {
            stopPoint.x += 10.0;
        }
        if (diffy < 0) {
            // Destination is to the left of current position
            stopPoint.y -= 10.0;
        } else if (diffy > 0) {
            stopPoint.y += 10.0;
        }
    }
    
    // Do the animation
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.frame = CGRectMake(stopPoint.x, stopPoint.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (withSnapBack) {
                             [UIView animateWithDuration:0.1
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.frame = CGRectMake(destination.x, destination.y, self.frame.size.width, self.frame.size.height);
                                              }
                                              completion:^(BOOL finished) {
                                                  SOSafePerformSelector(delegate, method, nil);
                                                  
                                              }];
                         } else {
                             SOSafePerformSelector(delegate, method, nil);
                             
                         }
                     }];
}


#pragma mark - Transforms

- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radianToDegrees(degrees));
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                             SOSafePerformSelector(delegate, method, nil);
                             
                         }
                     }];
}

- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformScale(self.transform, scaleX, scaleY);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                             SOSafePerformSelector(delegate, method, nil);
                         }
                     }];
}

- (void)spinClockwise:(float)secs {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radianToDegrees(90));
                     }
                     completion:^(BOOL finished) {
                         [self spinClockwise:secs];
                     }];
}

- (void)spinCounterClockwise:(float)secs {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radianToDegrees(270));
                     }
                     completion:^(BOOL finished) {
                         [self spinCounterClockwise:secs];
                     }];
}


#pragma mark - Transitions

- (void)curlDown:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^ { [self setAlpha:1.0]; }
                    completion:nil];
}

- (void)curlUpAndAway:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { [self setAlpha:0]; }
                    completion:nil];
}

- (void)drainAway:(float)secs {
    self.tag = 20;
    /*NSTimer *timer = */[NSTimer scheduledTimerWithTimeInterval:secs/50 target:self selector:@selector(drainTimer:) userInfo:nil repeats:YES];
}

- (void)drainTimer:(NSTimer*)timer {
    CGAffineTransform trans = CGAffineTransformRotate(CGAffineTransformScale(self.transform, 0.9, 0.9),0.314);
    self.transform = trans;
    self.alpha = self.alpha * 0.98;
    self.tag = self.tag - 1;
    if (self.tag <= 0) {
        [timer invalidate];
        timer = nil;
        [self removeFromSuperview];
    }
}

#pragma mark - Effects

- (void)changeAlpha:(float)newAlpha secs:(float)secs {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = newAlpha;
                     }
                     completion:nil];
}

- (void)pulse:(float)secs continuously:(BOOL)continuously {
    [UIView animateWithDuration:secs/2
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         // Fade out, but not completely
                         self.alpha = 0.3;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:secs/2
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              // Fade in
                                              self.alpha = 1.0;
                                          }
                                          completion:^(BOOL finished) {
                                              if (continuously) {
                                                  [self pulse:secs continuously:continuously];
                                              }
                                          }];
                     }];
}

@end

CGFloat const SODataStateDefaultHeight    = 66.0f;

static NSString * const _KeySONowScoreDataFont;
static NSString * const _KeySONowScoreDataState;
static NSString * const _KeySONowScoreDataWaring;
static NSString * const _KeySONowScoreDataImage;
static NSString * const _KeySONowScoreDataWaringLabel;
static NSString * const _KeySONowScoreDataImageView;
static NSString * const _KeySONowScoreDataImageSizeOffset;

static NSString * const _KeySONowScoreDataLoadingView;
static NSString * const _KeySONowScoreDataLoadingViewColor;

static NSString * const SONowScoreDataPositionKey;

static NSString * const SONowScoreDataDefaultWaringText = @"暂无数据";

static CGFloat  const SONowScoreDataDefaultImageSizeOffset = 0.6f;

@implementation UIView(DataState)

//+ (void)load {
//    Method m1 = class_getInstanceMethod([self class], @selector(layoutSubviews));
//    Method m2 = class_getInstanceMethod([self class], @selector(SOStateViewLayoutSubviews));
//    method_exchangeImplementations(m1, m2);
//}

- (CGPoint)dataStatePosition {
    id p = objc_getAssociatedObject(self, &SONowScoreDataPositionKey);
    if(p) {
        return ([p CGPointValue]);
    }
    return (CGPointMake(0.5f, 0.5f));
}

- (void)setDataStatePosition:(CGPoint)position {
    objc_setAssociatedObject(self, &SONowScoreDataPositionKey, [NSValue valueWithCGPoint:position], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self SONowScoreDataViewRefresh];
}

- (CGFloat)dataStateImageContentOffset {
    id obj_offset = objc_getAssociatedObject(self, &_KeySONowScoreDataImageSizeOffset);
    return (obj_offset ? [obj_offset floatValue] : SONowScoreDataDefaultImageSizeOffset);
}

- (void)setDataStateImageContentOffset:(CGFloat)offset {
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataImageSizeOffset,
                             @(offset),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)dataStateWaringFont {
    UIFont *font = objc_getAssociatedObject(self, &_KeySONowScoreDataFont);
    return (font ? font : [UIFont systemFontOfSize:12]);
}

- (void)setDataStateWaringFont:(UIFont *)font {
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataFont,
                             font,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)dataStateWaring {
    NSString *t = objc_getAssociatedObject(self, &_KeySONowScoreDataWaring);
    return (t ? t : SONowScoreDataDefaultWaringText);
}

- (void)setDataStateWaring:(NSString *)waring {
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataWaring,
                             waring,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self SONowScoreDataViewDataRefresh];
}

- (UIImage *)dataStateWaringImage {
    return (objc_getAssociatedObject(self, &_KeySONowScoreDataImage));
}

- (void)setDataStateWaringImage:(UIImage *)image {
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataImage,
                             image,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self SONowScoreDataViewDataRefresh];
}

- (UIColor *)dataStateLoadingViewColor {
    return (objc_getAssociatedObject(self, &_KeySONowScoreDataLoadingViewColor));
}

- (void)setDataStateLoadingViewColor:(UIColor *)color {
    if(!color) {
        color = [UIColor lightGrayColor];
    }
    if([self dataStateLoadingView]) {
        [[self dataStateLoadingView] setColor:color];
    }
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataLoadingViewColor,
                             color,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)dataStateLoadingView {
    return (objc_getAssociatedObject(self, &_KeySONowScoreDataLoadingView));
}

- (void)setDataStateLoadingView:(UIActivityIndicatorView *)loadingView {
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataLoadingView,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SOViewDataState)dataState {
    id obj_state = objc_getAssociatedObject(self, &_KeySONowScoreDataState);
    if(!obj_state) {
        return (SOViewDataStateNormal);
    }
    return ((SOViewDataState)[obj_state unsignedIntegerValue]);
}

- (void)setDataState:(SOViewDataState)dataState {
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataState,
                             @(dataState),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self SONowScoreDataViewRefresh];
}

- (UILabel *)waringLabel {
    return (objc_getAssociatedObject(self, &_KeySONowScoreDataWaringLabel));
}

- (UIImageView *)waringImageView {
    return (objc_getAssociatedObject(self, &_KeySONowScoreDataImageView));
}

- (void)SONowScoreDataViewDataRefresh {
    SOViewDataState state = [self dataState];
    if(SOViewDataStateNoData == state) {
        [self SONowScoreDataViewRefresh];
    }
}

- (void)SONowScoreDataViewRefresh {
    SOViewDataState state = [self dataState];
    UILabel *label = [self waringLabel];
    UIImageView *imageView = [self waringImageView];
    UIActivityIndicatorView *loadingView = [self dataStateLoadingView];
    
    switch (state) {
        case SOViewDataStateNormal: {
            if(label) {
                if([label superview]) {
                    [label removeFromSuperview];
                }
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataWaringLabel,
                                         nil,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                label = nil;
            }
            if(imageView) {
                if([imageView superview]) {
                    [imageView removeFromSuperview];
                }
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataImageView,
                                         nil,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                imageView = nil;
            }
            if(loadingView) {
                [loadingView stopAnimating];
                if([loadingView superview]) {
                    [loadingView removeFromSuperview];
                }
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataLoadingView,
                                         nil,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                loadingView = nil;
            }
        }break;
            
        case SOViewDataStateNoData: {
            if(loadingView) {
                [loadingView stopAnimating];
                if([loadingView superview]) {
                    [loadingView removeFromSuperview];
                }
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataLoadingView,
                                         nil,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                loadingView = nil;
            }
            
            if(!label) {
                label = [[UILabel alloc] init];
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor grayColor];
                label.textAlignment = NSTextAlignmentCenter;
                [self addSubview:label];
                [self bringSubviewToFront:label];
                //[label release];
                
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataWaringLabel,
                                         label,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            
            if(!imageView) {
                imageView = [[UIImageView alloc] init];
                imageView.backgroundColor = [UIColor clearColor];
                [self addSubview:imageView];
                [self bringSubviewToFront:imageView];
                //[imageView release];
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataImageView,
                                         imageView,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            NSString *text = [self dataStateWaring];
            UIImage *image = [self dataStateWaringImage];
            
            label.font = [self dataStateWaringFont];
            label.text = text;
            imageView.image = image;
            
            CGSize boundSize = self.bounds.size;
            CGSize textSize = [text soSizeWithFont:label.font constrainedToSize:boundSize lineBreakMode:label.lineBreakMode];
            
            CGSize imageSize = CGSizeMake(CGImageGetWidth(image.CGImage), CGImageGetHeight(image.CGImage));
            if(imageSize.width <= 0) {
                imageSize.width = 1.0f;
            }
            if(imageSize.height <= 0) {
                imageSize.height = 1.0f;
            }
            
            //限制图片大小
            CGFloat iw = MAX(1.0f, MIN(imageSize.width, boundSize.width * [self dataStateImageContentOffset]));
            CGFloat ih = imageSize.height * iw / imageSize.width;
            imageSize = CGSizeMake(iw, ih);
            ih = MIN(imageSize.height, boundSize.height * [self dataStateImageContentOffset]);
            iw = imageSize.width * ih / imageSize.height;
            imageSize = CGSizeMake(iw, ih);
            
            if(!text || [text length] == 0) {
                imageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
                imageView.center = CGPointMake(boundSize.width * [self dataStatePosition].x, boundSize.height * [self dataStatePosition].y);
                return;
            }
            if(!image) {
                //                label.frame = self.bounds;
                label.frame = CGRectMake(0, 0, SOScreenSize().width, self.bounds.size.height);
                return;
            }
            
            CGFloat space = 7.0f;
            CGPoint total_center = CGPointMake(boundSize.width * [self dataStatePosition].x, boundSize.height * [self dataStatePosition].y);
            CGFloat total_height = textSize.height + imageSize.height + space;
            imageView.frame = CGRectMake(0, total_center.y - total_height / 2.0f, imageSize.width, imageSize.height);
            label.frame = CGRectMake((boundSize.width - textSize.width) / 2.0f, CGRectGetMaxY(imageView.frame) + space, textSize.width, textSize.height);
            imageView.centerX = label.centerX = total_center.x;
        }break;
            
        case SOViewDataStateLoading: {
            if(label) {
                if([label superview]) {
                    [label removeFromSuperview];
                }
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataWaringLabel,
                                         nil,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                label = nil;
            }
            if(imageView) {
                if([imageView superview]) {
                    [imageView removeFromSuperview];
                }
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataImageView,
                                         nil,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                imageView = nil;
            }
            if(!loadingView) {
                loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                if([self dataStateLoadingViewColor]) {
                    loadingView.color = [self dataStateLoadingViewColor];
                }
                [self addSubview:loadingView];
                [self bringSubviewToFront:loadingView];
                //[loadingView release];
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataLoadingView,
                                         loadingView,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            loadingView.center = CGPointMake(CGRectGetWidth(self.bounds) * [self dataStatePosition].x, CGRectGetHeight(self.bounds) * [self dataStatePosition].y);
            [loadingView startAnimating];
        }break;
            
        default: break;
    }
}

- (void)SOStateViewLayoutSubviews {
    [self SONowScoreDataViewRefresh];
}

@end

@implementation UIView(SMKDebug)
- (void)SMKDebugWithBorderColor:(UIColor *)color borderWidth:(CGFloat)width {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}
@end


@implementation UIView(SMKAction)

/**
 *  @brief添加事件到view上的对象
 *
 *  @param object  添加view上的对象
 *  @param action  添加事件
 */
- (UITapGestureRecognizer *)addTarget:(id)object action:(SEL)action {
    self.userInteractionEnabled = YES;
    
    NSArray *gestures = [self gestureRecognizers];
    __block UITapGestureRecognizer *tapGesture = nil;
    [gestures indexOfObjectPassingTest:^BOOL(UITapGestureRecognizer *obj, NSUInteger idx, BOOL *stop) {
        if ([object isKindOfClass:[UITapGestureRecognizer class]]) {
            if (obj.numberOfTapsRequired == 1) {
                tapGesture = obj;
                *stop = YES;
                return YES;
            }
        }
        
        return NO;
    }];
    
    
    if (tapGesture == nil) {
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:object action:action];
    } else {
        [tapGesture addTarget:object action:action];
    }
    
    [self addGestureRecognizer:tapGesture];
    return tapGesture;
}


/**
 *  @brief移除view上的对象
 *
 *  @param object  移除view上的对象
 *  @param action  添加事件
 */
- (void)removeObject:(id)object action:(SEL)action {
    NSArray *gestures = [self gestureRecognizers];
    [gestures enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        UITapGestureRecognizer *gesture = obj;
        if ([gesture isMemberOfClass:[UITapGestureRecognizer class]]) {
            [gesture removeTarget:object action:action];
        }
    }];
}

/**
 *  @brief长按手势的事件响应
 *
 *  @param object 添加到的对象
 *  @param action 添加的事件
 *
 *  @return
 */
- (UILongPressGestureRecognizer *)addLongPressTarget:(id)object action:(SEL)action {
    self.userInteractionEnabled = YES;
    NSArray *gestures = [self gestureRecognizers];
    __block UILongPressGestureRecognizer *longPressGesture = nil;
    [gestures indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        if ([object isKindOfClass:[UILongPressGestureRecognizer class]]) {
            longPressGesture = obj;
            *stop = YES;
            return YES;
        }
        
        return NO;
    }];
    
    if (longPressGesture == nil) {
        longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:action];
        longPressGesture.minimumPressDuration = 1;
    } else {
        [longPressGesture addTarget:self action:action];
    }
    
    [self addGestureRecognizer:longPressGesture];
    return longPressGesture;
}

//@brief 移除长按手势
- (void)removeLongPressTarget:(id)object ation:(SEL)action {
    NSArray *gestures = [self gestureRecognizers];
    [gestures enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        UILongPressGestureRecognizer *gesture = obj;
        if ([gesture isMemberOfClass:[UILongPressGestureRecognizer class]]) {
            [gesture removeTarget:object action:action];
        }
    }];
}


@end


@implementation UIView(SMK_BlockGesture)


- (void)smk_addTapActionWithBlock:(GestureActionBlock)block
{
    UITapGestureRecognizer *gesture = [self smk_associatedValueForKey:_cmd];
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(smk_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        [self smk_setAssociateValue:gesture withKey:_cmd];
    }
    
    [self smk_setAssociateCopyValue:block withKey:&kActionHandlerTapBlockKey];
    self.userInteractionEnabled = YES;
}

- (void)smk_handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        GestureActionBlock block = [self smk_associatedValueForKey:&kActionHandlerTapBlockKey];
        if (block)
        {
            block(gesture);
        }
    }
}

- (void)smk_addLongPressActionWithBlock:(GestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = [self smk_associatedValueForKey:_cmd];
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(smk_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        [self smk_setAssociateValue:gesture withKey:_cmd];
    }
    
    [self smk_setAssociateCopyValue:block withKey:&kActionHandlerLongPressBlockKey];
    self.userInteractionEnabled = YES;
}

- (void)smk_handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        GestureActionBlock block = [self smk_associatedValueForKey:&kActionHandlerLongPressBlockKey];
        if (block)
        {
            block(gesture);
        }
    }
}

@end



@implementation UIView(SMKLayer)

- (void)setRound:(CGFloat)round {
    self.layer.cornerRadius = round;
    self.layer.masksToBounds = YES;
}

- (CGFloat)round {
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.masksToBounds = YES;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWith:(CGFloat)width color:(UIColor *)color {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.masksToBounds = YES;
}

- (void)setSmk_shadowColor:(UIColor *)smk_shadowColor {
    self.layer.shadowColor = smk_shadowColor.CGColor;
}

- (UIColor *)smk_shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setSmk_shadowOffset:(CGSize)smk_shadowOffset{
    self.layer.shadowOffset = smk_shadowOffset;
}

- (CGSize)smk_shadowOffset{
    return self.layer.shadowOffset;
}

- (void)setSmk_shadowRadius:(CGFloat)smk_shadowRadius{
    self.layer.shadowRadius = smk_shadowRadius;
}

- (CGFloat)smk_shadowRadius {
    return self.layer.shadowRadius;
}

- (void)setSmk_shadowOpacity:(CGFloat)smk_shadowOpacity{
    self.layer.shadowOpacity = smk_shadowOpacity;
}

- (CGFloat)smk_shadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)smk_setBorderWith:(CGFloat)width color:(UIColor *)color top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right {
    if (top) {
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, width)];
        subView.backgroundColor = color;
        [self addSubview:subView];
        
        if (self.translatesAutoresizingMaskIntoConstraints == NO) {
            subView.translatesAutoresizingMaskIntoConstraints = NO;
            NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subView)];
            NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView(height)]" options:0 metrics:@{@"height": @(width)} views:NSDictionaryOfVariableBindings(subView)];
            [self addConstraints:constraintH];
            [self addConstraints:constraintV];
        }
        
    }
    
    if (left) {
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.height)];
        subView.backgroundColor = color;
        
        [self addSubview:subView];
        
        if (self.translatesAutoresizingMaskIntoConstraints == NO) {
            subView.translatesAutoresizingMaskIntoConstraints = NO;
            NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView(width)]" options:0 metrics:@{@"width": @(width)}  views:NSDictionaryOfVariableBindings(subView)];
            NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subView)];
            [self addConstraints:constraintH];
            [self addConstraints:constraintV];
        }
    }
    
    
    if (bottom) {
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - width, self.width, width)];
        subView.backgroundColor = color;
        [self addSubview:subView];
        
        if (self.translatesAutoresizingMaskIntoConstraints == NO) {
            subView.translatesAutoresizingMaskIntoConstraints = NO;
            NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subView)];
            NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[subView(height)]|" options:0 metrics:@{@"height": @(width)} views:NSDictionaryOfVariableBindings(subView)];
            [self addConstraints:constraintH];
            [self addConstraints:constraintV];
        }
    }
    
    
    if (right) {
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(self.width - width, 0, width, self.height)];
        subView.backgroundColor = color;
        [self addSubview:subView];
        
        if (self.translatesAutoresizingMaskIntoConstraints == NO) {
            subView.translatesAutoresizingMaskIntoConstraints = NO;
            NSArray *constraintH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[subView(width)]|" options:0 metrics:@{@"width": @(width)}  views:NSDictionaryOfVariableBindings(subView)];
            NSArray *constraintV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subView)];
            [self addConstraints:constraintH];
            [self addConstraints:constraintV];
        }
    }
}

- (void)smk_setTopBorderWith:(CGFloat)width color:(UIColor *)color {[self smk_setBorderWith:width color:color top:YES left:NO bottom:NO right:NO];}
- (void)smk_setLeftBorderWith:(CGFloat)width color:(UIColor *)color {[self smk_setBorderWith:width color:color top:NO left:YES bottom:NO right:NO];}
- (void)smk_setBottomBorderWith:(CGFloat)width color:(UIColor *)color {[self smk_setBorderWith:width color:color top:NO left:NO bottom:YES right:NO];}
- (void)smk_setRightBorderWith:(CGFloat)width color:(UIColor *)color {[self smk_setBorderWith:width color:color top:NO left:NO bottom:NO right:YES];}

@end


@implementation UIView (SMK_Image)

- (UIImage *)smk_screenshot {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation UIView (UIViewRoundCorner)

#pragma mark - 添加圆角纯色背景
- (void)addRoundCornerWithBGColor:(UIColor *)color andRadius:(CGFloat)radius
{
    UIImageView *imageView = [self createRoundCornerRadiusBGImageView:radius];
    imageView.backgroundColor = color;
}

#pragma mark - 添加圆角背景图片
- (void)addRoundCornerWithBGImage:(UIImage *)image andRadius:(CGFloat)radius;
{
    UIImageView *imageView = [self createRoundCornerRadiusBGImageView:radius];
    imageView.image = image;
}

#pragma mark - 创建圆角的imageView
- (UIImageView *)createRoundCornerRadiusBGImageView:(CGFloat)radius
{
    // 0.清除当前View的背景色
    self.backgroundColor = [UIColor clearColor];
    
    // 1.创建一个UIImageView，并添加到当前View层上
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    
    // 2.将该UIImageView置于当前View的底层
    [self sendSubviewToBack:imageView];
    
    // 3.设置imageView的圆角以及圆角半径
    imageView.layer.cornerRadius = radius;
    imageView.layer.masksToBounds = YES;
    
    // 4.添加约束
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(imageView);
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
    // 5.返回imageView
    return imageView;
}


@end
