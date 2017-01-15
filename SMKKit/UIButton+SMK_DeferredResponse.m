//
//  UIButton+SMK_DeferredResponse.m
//  SMKKit
//
//  Created by Kenvin on 2016/11/2.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "UIButton+SMK_DeferredResponse.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, assign) NSTimeInterval custom_acceptEventTime;

@end

@implementation UIButton (SMK_DeferredResponse)


+ (void)load{
    
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    Method customMethod = class_getInstanceMethod(self, @selector(custom_sendAction:to:forEvent:));
    SEL customSEL = @selector(custom_sendAction:to:forEvent:);
    
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self, customSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, customMethod);
    }
}

- (NSTimeInterval )custom_acceptEventInterval{
    return [objc_getAssociatedObject(self, "UIButton_acceptEventInterval") doubleValue];
}

- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{
    objc_setAssociatedObject(self, "UIButton_acceptEventInterval", @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval )custom_acceptEventTime{
    return [objc_getAssociatedObject(self, "UIButton_acceptEventTime") doubleValue];
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{
    objc_setAssociatedObject(self, "UIButton_acceptEventTime", @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    

     if (self.custom_acceptEventInterval <= 0) {
        self.custom_acceptEventInterval = 1;
     }
    
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= self.custom_acceptEventInterval);
    
    if (self.custom_acceptEventInterval > 0) {
        self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    if (needSendAction) {
        [self custom_sendAction:action to:target forEvent:event];
    }
    
    
}
@end
