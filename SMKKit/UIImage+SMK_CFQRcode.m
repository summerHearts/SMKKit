//
//  UIImage+SMK_CFQRcode.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "UIImage+SMK_CFQRcode.h"

@implementation UIImage (SMK_CFQRcode)

#pragma mark - 生成原始二维码
+ (void)qrImageWithString:(NSString *)string size:(CGFloat)size completion:(void (^)(UIImage *image))completion{
    
    [UIImage qrImageWithString:string size:size iconImage:nil scale:0 completion:completion];
}


#pragma mark - 带图片二维码(图片为默认比例0.2、默认方形)
+ (void)qrImageWithString:(NSString *)string size:(CGFloat)size iconImage:(UIImage *)iconImage  completion:(void (^)(UIImage * image))completion {
    
    [self qrImageWithString:string size:size iconImage:iconImage scale:0.20 completion:completion];
}

#pragma mark - 带图片二维码（图片指定比例、方形）
+ (void)qrImageWithString:(NSString *)string  size:(CGFloat)size iconImage:(UIImage *)iconImage scale:(CGFloat)scale completion:(void (^)(UIImage * image))completion {
    // 传入 CenterImgType_Square
    [UIImage qrImageWithString:string size:size CenterImageType:CenterImgType_Square iconImage:iconImage scale:scale completion:completion];
}

#pragma mark - 带图片二维码（图片指定比例、指定CenterImgType）
+ (void)qrImageWithString:(NSString *)string size:(CGFloat)size CenterImageType:(CenterImgType)type iconImage:(UIImage *)iconImage scale:(CGFloat)scale completion:(void (^)(UIImage *image))completion{
    // 断言
    NSAssert(completion, @"必须传入完成回调");
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 获取输出文件
        CIImage *ciImage = [UIImage qrImageWithString:string];
        
        // 放大为高清图
        UIImage *qrImage = [UIImage qrCodeImage:ciImage size:size];
        
        // 添加中间小图片
        qrImage = [self qrcodeImage:qrImage addIconImage:iconImage centerImageType:type scale:scale];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回调
            completion(qrImage);
        });
    });
    
}


#pragma mark - 给二维码设置背景（默认方形）
+ (void)qrIamge:(UIImage *)qrImage addBgImage:(UIImage *)bgImage bgImageSize:(CGFloat) bgImageSize completion:(void (^)(UIImage *image))completion{
    [UIImage qrIamge:qrImage qrImageType:CenterImgType_Square addBgImage:bgImage bgImageSize:bgImageSize completion:completion];
}
#pragma mark - 给二维码设置背景
+ (void)qrIamge:(UIImage *)qrImage qrImageType:(CenterImgType)type addBgImage:(UIImage *)bgImage bgImageSize:(CGFloat) bgImageSize completion:(void (^)(UIImage *image))completion{
    
    // 断言
    NSAssert(completion, @"必须传入完成回调");
    // 为二维码添加自定义背景
    
    __block UIImage * bgImg;
    __block UIImage * qrImg;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 保证背景、二维码两者的像素比例合适，分辨率跟newImage一致
        bgImg = [self imageCompressForSize:bgImage targetSize:CGSizeMake(bgImageSize, bgImageSize)];
        qrImg = [self imageCompressForSize:qrImage targetSize:qrImage.size];
        
        UIImage *newImage = [UIImage qrcodeImage:bgImg addIconImage:qrImg centerImageType:type scale:1.0 * qrImg.size.width /  bgImg.size.width];;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(newImage);
        });
    });
    
}

#pragma mark - 字符串生成CIImage
+ (CIImage *)qrImageWithString:(NSString *)string{
    // 创建过滤器
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 设置默认过滤属性
    [qrFilter setDefaults];
    
    // 使用KVC设置属性 (将字符串转为data)
    [qrFilter setValue:[string dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
    
    // 获取输出文件
    CIImage *ciImage = qrFilter.outputImage;

    return ciImage;
}


#pragma mark  将CIImage转为高清的UIImage
+ (UIImage *)qrCodeImage:(CIImage *)ciImage size:(CGFloat)size {
    //
    CGRect extent = CGRectIntegral(ciImage.extent);
    // 倍数
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    //return [UIImage imageWithCGImage:scaledImage]; // 分辨率为72
    return [UIImage imageWithCGImage:scaledImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]; // 分辨率根据屏幕分辨率扩大相应倍数 72 * 倍数
}

#pragma mark  小图片二维码合并
+ (UIImage *)qrcodeImage:(UIImage *)qrImage addIconImage:(UIImage *)iconImage centerImageType:(CenterImgType) type scale:(CGFloat)scale {
    // 图片放大倍数等于屏幕分辨类
    CGFloat screenScale = [UIScreen mainScreen].scale; // 是屏幕分辨率
    CGRect rect = CGRectMake(0, 0, qrImage.size.width * screenScale, qrImage.size.height * screenScale);
    
   UIGraphicsBeginImageContextWithOptions(rect.size, YES, screenScale);
    
    [qrImage drawInRect:rect];
    
    if(iconImage){ // 如果有图片
        
        CGSize avatarSize = CGSizeMake(rect.size.width * scale, rect.size.height * scale);
        CGFloat x = (rect.size.width - avatarSize.width) * 0.5;
        CGFloat y = (rect.size.height - avatarSize.height) * 0.5;
        if (type == CenterImgType_Circle) { // 如果为圆形
            
            iconImage = [UIImage createCircularImage:iconImage];
            
        }else if (type == CenterImgType_CornorRadious){
            iconImage = [UIImage imageWithRoundedCorners:iconImage Size:avatarSize andCornerRadius:5.0f];
        }
        
        [iconImage drawInRect:CGRectMake(x, y, avatarSize.width, avatarSize.height)];
    }
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithCGImage:result.CGImage scale:screenScale orientation:UIImageOrientationUp] ;
}



#pragma mark - 剪裁圆形图片
+ (instancetype)createCircularImage:(UIImage *)iconImage{
    // 1. 创建一个bitmap类型图形上下文（空白的UiImage）
    // NO 将来创建的透明的UiImage
    // YES 不透明
    UIGraphicsBeginImageContextWithOptions(iconImage.size, NO, 0);
    
    // 2. 指定可用范围
    // 2.1 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.2 画圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, iconImage.size.width, iconImage.size.height));
    
    // 2.3 裁剪，指定将来可以画图的可用范围
    CGContextClip(ctx);
    
    // 3. 绘制图片
    [iconImage drawInRect:CGRectMake(0, 0, iconImage.size.width, iconImage.size.height)];
    
    // 4. 取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.1 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 图片切圆角
+ (UIImage *)imageWithRoundedCorners: (UIImage *)image Size:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius{
    
    CGRect rect = (CGRect){0.f, 0.f, sizeToFit};
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
    
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [image drawInRect:rect];
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return output;
}


//按比例缩放,size 是你要把图显示到 多大区域 分辨率为72 * [UIScreen mainScreen].scale
#pragma mark  图片生成指定大小的img
+ (UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size {
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
            
        }
        else{
            
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
    }
    
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithCGImage:newImage.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
}



// 绘制图片 与合并二维码、小图片方法一致
//+ (UIImage *)createNewImageWithBgImage:(UIImage *)bgImage qrImage:(UIImage *)qrImage qrImageSize:(CGFloat)qrImageSize{
//    
//   return  [UIImage qrcodeImage:bgImage addIconImage:qrImage centerImageType:CenterImgType_Square scale:1.0 * qrImage.size.width /  bgImage.size.width];
//    
////    CGFloat screenScale = [UIScreen mainScreen].scale;
////    
////    CGRect rect = CGRectMake(0, 0, bgImage.size.width *screenScale, bgImage.size.height * screenScale);
////    // 1.开启图片上下文
////    UIGraphicsBeginImageContextWithOptions(rect.size, YES, screenScale);
////    // 2.绘制背景
////    [bgImage drawInRect:rect];
////    
////    // 3.绘制图标
////    CGFloat imageW = qrImageSize * screenScale;
////    CGFloat imageH = qrImageSize * screenScale;
////    CGFloat imageX = (bgImage.size.width * screenScale - imageW) * 0.5;
////    CGFloat imageY = (bgImage.size.height* screenScale - imageH) * 0.5;
////    [qrImage drawInRect:CGRectMake(imageX, imageY, imageW, imageH)];
////    
////    // 4.取出绘制好的图片
////    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
////    // 5.关闭上下文
////    UIGraphicsEndImageContext();
////    
////    // 6.返回生成好得图片
////    return [UIImage imageWithCGImage:newImage.CGImage scale:screenScale orientation:UIImageOrientationUp];
//}

#pragma mark  颜色转换成图片
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark  拉伸图片
+ (UIImage *)resizableImage:(UIImage *)image
{
    //default is 2
    CGFloat top = image.size.height / 5; // 顶端盖高度
    CGFloat bottom = image.size.height / 5 ; // 底端盖高度
    CGFloat left = image.size.width / 5; // 左端盖宽度
    CGFloat right = image.size.width / 5; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    return [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

#pragma mark  高斯模糊图片
+ (UIImage *)createGaussianImage:(UIImage *)image
{
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey, inputImage,@"inputRadius", @(70.5), nil];
    
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[inputImage extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    
    return resultImage;
}


@end
