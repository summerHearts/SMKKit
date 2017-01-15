//
//  NSDictionary+SMK_Kit.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "NSDictionary+SMK_Kit.h"

@implementation NSDictionary(SMK_Kit)
- (NSString*)stringForKey:(id)aKey{
    if ([[self objectForKey:aKey] isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if ([[self objectForKey:aKey] isKindOfClass:[NSString class]]) {
        return [self objectForKey:aKey];
    }
    else{
        return @"";
    }
}

- (NSInteger)integerForKey:(id)aKey
{
    NSString *strValue = [self stringForKey:aKey];
    if ([self isBlankString:strValue]) {
        return 0;
    }
    return [strValue integerValue];
}

- (CGFloat)floatForKey:(id)aKey
{
    NSString *strValue = [self stringForKey:aKey];
    if ([self isBlankString:strValue]) {
        return 0;
    }
    return [strValue floatValue];
}

- (id)safeJsonObjectForKey:(id <NSCopying>)key {
    id ob = [self objectForKey:key];
    if(ob == [NSNull null]) {
        return (nil);
    }
    return (ob);
}

//判断空字符串
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+(NSMutableDictionary *)setName:(NSString *)name value:(NSString *)value{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:name forKey:@"name"];
    [dict setObject:value forKey:@"value"];
    return dict;
}
@end
