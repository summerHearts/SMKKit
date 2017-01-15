//
//  NSDictionary+SMK_Kit.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary(SMK_Kit)

- (NSString*)stringForKey:(id)aKey;

- (NSInteger)integerForKey:(id)aKey;

- (CGFloat)floatForKey:(id)aKey;

- (id)safeJsonObjectForKey:(id <NSCopying>)key;

+(NSMutableDictionary *)setName:(NSString *)name value:(NSString *)value;

@end
