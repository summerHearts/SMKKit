//
//  NSObject+SOObject.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "NSObject+SOObject.h"
#import <objc/runtime.h>

@implementation NSObject(SOObject)

-(BOOL)smk_isNotEmpty
{
    return !(self == nil
             || ([self respondsToSelector:@selector(length)]
                 && [(NSData *)self length] == 0)
             || ([self respondsToSelector:@selector(count)]
                 && [(NSArray *)self count] == 0));
   
};

- (void)smk_setAssociateValue:(id)value withKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (void)smk_setAssociateWeakValue:(id)value withKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (void)smk_setAssociateCopyValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id)smk_associatedValueForKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}


@end


@implementation NSArray(SOObject)

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

@implementation NSMutableArray(SOObject)

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

@end


#define checkNull(__X__) (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]





@implementation NSMutableDictionary(SOObject)

- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if(!aKey || !anObject) {
        NSLog(@"--- setObject:forKey: key must not nil");
    } else {
        [self setObject:anObject forKey:aKey];
    }
}

@end

