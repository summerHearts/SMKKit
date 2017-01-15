//
//  UINavigationBar+SMK_NavigationShadow.m
//  SMKKit
//
//  Created by Kenvin on 16/11/28.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "UINavigationBar+SMK_NavigationShadow.h"

@implementation UINavigationBar (SMK_NavigationShadow)

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    
    self.clipsToBounds = NO;
    
}
@end
