//
//  NSString+Emoji.h
//  BHFangChuang
//
//  Created by 于德志 on 16/3/29.
//  Copyright © 2016年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)

+ (BOOL)stringContainsEmoji:(NSString *)string;


/**
 字符转emoji
 Returns a NSString in which any occurrences that match the cheat codes
 from Emoji Cheat Sheet <http://www.emoji-cheat-sheet.com> are replaced by the
 corresponding unicode characters.
 
 Example:
 "This is a smiley face :smiley:"
 
 Will be replaced with:
 "This is a smiley face \U0001F604"
 */
- (NSString *)stringByReplacingEmojiCheatCodesWithUnicode;

/**
 emoji转字符
 Returns a NSString in which any occurrences that match the unicode characters
 of the emoji emoticons are replaced by the corresponding cheat codes from
 Emoji Cheat Sheet <http://www.emoji-cheat-sheet.com>.
 
 Example:
 "This is a smiley face \U0001F604"
 
 Will be replaced with:
 "This is a smiley face :smiley:"
 */
- (NSString *)stringByReplacingEmojiUnicodeWithCheatCodes;

@end
