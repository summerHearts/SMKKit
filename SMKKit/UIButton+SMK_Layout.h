//
//  UIButton+SMK_Layout.h
//  SMKKit
//
//  Created by Kenvin on 16/12/7.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SMKImagePosition) {
    SMKImagePositionLeft = 0,              //图片在左，文字在右，默认
    SMKImagePositionRight = 1,             //图片在右，文字在左
    SMKImagePositionTop = 2,               //图片在上，文字在下
    SMKImagePositionBottom = 3,            //图片在下，文字在上
    SMKImagePositionTopCenter = 4,         //图片在中间，文字在下面
};


@interface UIButton (SMK_Layout)

/**
  文字绝对布局
 */
@property (nonatomic,assign) CGRect titleRect;

/**
 图片绝对布局
 */
@property (nonatomic,assign) CGRect imageRect;

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(SMKImagePosition)postion spacing:(CGFloat)spacing;
@end
