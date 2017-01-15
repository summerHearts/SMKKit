//
//  UIImage+SMK_CFQRcode.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CenterImgType) {
    // 方形
    CenterImgType_Square,
    // 圆形
    CenterImgType_Circle,
    // 切圆角
    CenterImgType_CornorRadious
};

@interface UIImage (SMK_CFQRcode)
/**
 *  异步生成原始的二维码（中间不带图片）
 *
 *  @param string 数据
 *  @param size 二维码的大小
 *  @param completion 二维码制作成功回调block
 */
+ (void)qrImageWithString:(NSString *)string size:(CGFloat)size completion:(void (^)(UIImage *image))completion;


///  异步生成二维码图像(默认方形，默认比例)
///
/// @param string     二维码图像的字符串
/// @param size       二维码的大小
/// @param iconIamge  头像图像，默认比例 0.2
/// @param completion 完成回调
+ (void)qrImageWithString:(NSString *)string  size:(CGFloat)size iconImage:(UIImage *)iconImage completion:(void (^)(UIImage *image))completion;

/// 异步生成二维码图像(默认方形，指定比例)
///
/// @param string     二维码图像的字符串
/// @param size       二维码的大小
/// @param iconImage  头像图像
/// @param scale      头像占二维码图像的比例
/// @param completion 完成回调
+ (void)qrImageWithString:(NSString *)string size:(CGFloat)size iconImage:(UIImage *)iconImage scale:(CGFloat)scale completion:(void (^)(UIImage * image))completion;


/**
 *  异步生成带图片的二维码 (指定形状，指定比例)
 *
 *  @param string    数据
 *  @param size      二维码的大小
 *  @param type      自定义二维码图片的种类（中间图片为方形，中间图片为圆形）
 *  @param image     中间图片
 *  @param imageSize 中间图片的大小
 *  @param completion 二维码制作成功回调block
 */
+ (void)qrImageWithString:(NSString *)string size:(CGFloat)size CenterImageType:(CenterImgType)type iconImage:(UIImage *)iconImage scale:(CGFloat)scale  completion:(void (^)(UIImage *image))completion;


/**
 *  为二维码添加自定义背景，二维码形状为方形
 *
 *  @param qrImage     二维码图片
 *  @param bgImage     背景图片
 *  @param bgImageSize 背景图片大小
 *  @param completion  成功回调block
 */
+ (void)qrIamge:(UIImage *)qrImage addBgImage:(UIImage *)bgImage bgImageSize:(CGFloat) bgImageSize completion:(void (^)(UIImage *image))completion;

/**
 *  为二维码添加自定义背景,设置二维码显示形状
 *
 *  @param qrImage     二维码
 *  @param type        形状
 *  @param bgImage     背景图片
 *  @param bgImageSize 背景图片大小
 *  @param completion  成功回调
 */
+ (void)qrIamge:(UIImage *)qrImage qrImageType:(CenterImgType)type addBgImage:(UIImage *)bgImage bgImageSize:(CGFloat) bgImageSize completion:(void (^)(UIImage *image))completion;

@end
