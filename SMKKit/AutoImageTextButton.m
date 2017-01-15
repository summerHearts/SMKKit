//
//  AutoImageTextButton.m
//  SMKKit
//
//  Created by Kenvin on 16/12/7.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "AutoImageTextButton.h"

@implementation AutoImageTextButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return self.titleRect;
    }
    return [super titleRectForContentRect:contentRect];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    if (!CGRectIsEmpty(self.imageRect) && !CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    }
    return [super imageRectForContentRect:contentRect];
}

@end
