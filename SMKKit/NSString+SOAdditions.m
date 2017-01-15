//
//  NSString+Size.m
//  FangChuang
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSString+SOAdditions.h"

@implementation NSString(SOSize)

- (CGSize)soSizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width {
    return ([self soSizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping]);
}

- (CGSize)soSizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width lineBreakMode:(NSInteger)lineBreakMode {
    return ([self soSizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:lineBreakMode]);
}

- (CGSize)soSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return ([self soSizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping]);
}

- (CGSize)soSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSInteger)lineBreakMode {
#ifdef __IPHONE_7_0
    return ([self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size);
#else
    return ([self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreak]);
#endif
}

@end


@implementation NSString(SOAdditions)

- (NSString *)trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)empty{
    return @"";
}

- (NSString *)urlEncoded {
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                             (CFStringRef)self,NULL,
                                                                             (CFStringRef)@"!#$%&'()*+,/:;=?@[]",
                                                                             kCFStringEncodingUTF8);
    
    NSString *urlEncoded = [NSString stringWithString:(__bridge NSString *)cfUrlEncodedString];
    CFRelease(cfUrlEncodedString);
    return urlEncoded;
}


-(NSString *)md5Com
{
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15]];
}

-(NSString *)md5
{
    const char* cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    static const char HexEncodeChars[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
    char *resultData = malloc(CC_MD5_DIGEST_LENGTH * 2 + 1);
    
    for (uint index = 0; index < CC_MD5_DIGEST_LENGTH; index++) {
        resultData[index * 2] = HexEncodeChars[(result[index] >> 4)];
        resultData[index * 2 + 1] = HexEncodeChars[(result[index] % 0x10)];
    }
    resultData[CC_MD5_DIGEST_LENGTH * 2] = 0;
    
    NSString *resultString = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
    free(resultData);
    
    return [resultString uppercaseString];
}

- (NSString *)md5:(NSString *)key
{
    const char* cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    char HexEncodeChars[16] = {'0','1','2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};;
    if (key) {
        NSArray *arr =  [key componentsSeparatedByString:@","];
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i < arr.count; i++) {
            [str appendString:arr[i]];
        }
        memcpy(HexEncodeChars, [str cStringUsingEncoding:NSASCIIStringEncoding], str.length);
    }
    
    char *resultData = malloc(CC_MD5_DIGEST_LENGTH * 2 + 1);
    
    for (uint index = 0; index < CC_MD5_DIGEST_LENGTH; index++) {
        resultData[index * 2] = HexEncodeChars[(result[index] >> 4)];
        resultData[index * 2 + 1] = HexEncodeChars[(result[index] % 0x10)];
    }
    resultData[CC_MD5_DIGEST_LENGTH * 2] = 0;
    
    NSString *resultString = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
    free(resultData);
    return [resultString uppercaseString];
}


- (NSString *)ChineaseStringToASIIString {
    NSMutableString *source = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    return (source);
}

@end
