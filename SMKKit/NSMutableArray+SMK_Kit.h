//
//  NSMutableArray+SMK_Kit.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (SMK_Kit)

- (void)safeAddObject:(id)anObject;

- (void)safeInsertObject:(id)anObject atIndex:(NSInteger)index;

- (void)insertsObject:(NSObject *)object atIndex:(NSUInteger)index;

- (void)safeRemoveObjectAtIndex:(NSInteger)index;

- (void)safeReplaceObjectAtIndex:(NSInteger)index withObject:(id)anObject;

- (void)addUniqueObject:(id)object;
@end
