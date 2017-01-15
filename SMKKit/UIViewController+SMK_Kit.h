//
//  UIViewController+SMK_Kit.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SWIZZ_IT [UIViewController swizzIt];
#define SWIZZ_IT_WITH_TAG(tag) [UIViewController swizzItWithTag:tag];

#define UN_SWIZZ_IT [UIViewController undoSwizz];

@interface UIViewController (SMK_Kit)

+ (void)swizzIt;

+ (void)swizzItWithTag:(NSString *)tag;

+ (void)undoSwizz;

@end
