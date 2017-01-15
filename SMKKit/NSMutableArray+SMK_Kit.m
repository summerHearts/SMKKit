//
//  NSMutableArray+SMK_Kit.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//
#import "NSMutableArray+SMK_Kit.h"

@implementation NSMutableArray (SMK_Kit)

- (void)safeAddObject:(id)anObject {
    if(!anObject) {
        return;
    }
    [self addObject:anObject];
}

- (void)safeInsertObject:(id)anObject atIndex:(NSInteger)index {
    if(index < 0) {
        return;
    }
    if(index > MAX((NSInteger)self.count - 1, 0)) {
        NSLog(@"--- insertObject:atIndex: out of array range ---");
        return;
    }
    if(!anObject) {
        NSLog(@"--- insertObject:atIndex: object must not nil ---");
        return;
    }
    [self insertObject:anObject atIndex:index];
}
- (void)insertsObject:(NSObject *)object atIndex:(NSUInteger)index{
    @synchronized (self) {
        [self insertObject:object atIndex:index];
    }
}
- (void)safeRemoveObjectAtIndex:(NSInteger)index {
    if(index < 0) {
        return;
    }
    if(index > MAX((NSInteger)self.count - 1, 0)) {
        NSLog(@"--- removeObjectAtIndex: out of array range ---");
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)safeReplaceObjectAtIndex:(NSInteger)index withObject:(id)anObject {
    if (self.count==0) {
        return;
    }
    if(index < 0) {
        return;
    }
    if(index > MAX((NSInteger)self.count - 1, 0)) {
        NSLog(@"--- replaceObjectAtIndex:atIndex: out of array range ---");
        return;
    }
    
    if(!anObject) {
        NSLog(@"--- replaceObjectAtIndex:atIndex: object must not nil ---");
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (void)addUniqueObject:(id)object {
    NSUInteger existingIndex = [self indexOfObject:object];
    if(existingIndex == NSNotFound) {
        [self addObject:object];
        return;
    }
    [self replaceObjectAtIndex:existingIndex withObject:object];
}
@end
