//
//  NSArray+SMK_Kit.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "NSArray+SMK_Kit.h"

@implementation NSArray (SMK_Kit)

- (id)safeObjectAtIndex:(NSInteger)index {
    if(index < 0) {
        return (nil);
    }
    if(self.count == 0) {
        return (nil);
    }
    if(index > MAX(self.count - 1, 0)) {
        return (nil);
    }
    return ([self objectAtIndex:index]);
}

@end
