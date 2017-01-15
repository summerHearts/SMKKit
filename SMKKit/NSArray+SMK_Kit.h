//
//  NSArray+SMK_Kit.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SMK_Kit)

//NSArray objectAtIndex:的安全方法，避免数组越界造成的崩溃
- (id)safeObjectAtIndex:(NSInteger)index;

@end
