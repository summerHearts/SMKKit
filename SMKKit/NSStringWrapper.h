//
//  NSStringWrapper.h
//  NSStringWrapper
//
//  Created by Tang Qiao on 12-2-4.
//  Copyright (c) 2012年 blog.devtang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Wrapper)

/**  Return the char value at the specified index. */
- (unichar) charAt:(NSInteger)index;

/**
 * Compares two strings lexicographically.
 * the value 0 if the argument string is equal to this string;
 * a value less than 0 if this string is lexicographically less than the string argument;
 * and a value greater than 0 if this string is lexicographically greater than the string argument.
 */
- (NSInteger) compareTo:(NSString*) anotherString;

- (NSInteger) compareToIgnoreCase:(NSString*) str;

- (BOOL) contains:(NSString*) str;

- (BOOL) startsWith:(NSString*)prefix;

- (BOOL) endsWith:(NSString*)suffix;

- (BOOL) equals:(NSString*) anotherString;

- (BOOL) equalsIgnoreCase:(NSString*) anotherString;

- (NSInteger) indexOfChar:(unichar)ch;

- (NSInteger) indexOfChar:(unichar)ch fromIndex:(NSInteger)index;

- (NSInteger) indexOfString:(NSString*)str;

- (NSInteger) indexOfString:(NSString*)str fromIndex:(NSInteger)index;

- (NSInteger) lastIndexOfChar:(unichar)ch;

- (NSInteger) lastIndexOfChar:(unichar)ch fromIndex:(NSInteger)index;

- (NSInteger) lastIndexOfString:(NSString*)str;

- (NSInteger) lastIndexOfString:(NSString*)str fromIndex:(NSInteger)index;

- (NSString *) substringFromIndex:(NSInteger)beginIndex toIndex:(NSInteger)endIndex;

- (NSString *) toLowerCase;

- (NSString *) toUpperCase;

- (NSString *) trim;

- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement;

- (NSArray *) split:(NSString*) separator;

@end






