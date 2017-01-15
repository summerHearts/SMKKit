//
//  RegexCheckHelper.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexCheckHelper : NSObject

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile;

//用户名
+ (BOOL)validateUserName:(NSString *)name;

//密码
+ (BOOL)validatePassword:(NSString *)passWord;

//昵称
+ (BOOL)validateNickname:(NSString *)nickname;

//身份证号
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

//判断是否为整形
+(BOOL)validatePureInt:(NSString *)string;

//判断是否为浮点形
+(BOOL)validatePureFloat:(NSString *)string;

//判断是否URL
+(BOOL)validateHttpURL:(NSString *)string;
@end
