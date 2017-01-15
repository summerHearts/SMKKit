//
//  UIImage+SMK_applyBlurOnImage.h
//  SMKKit
//
//  Created by YDZ on 16/9/18.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SMK_applyBlurOnImage)

+ (UIImage *)p_applyBlurOnImage:(UIImage *)imageToBlur withRadius:(CGFloat)blurRadius;
+ (UIImage *)catchImage;
@end
