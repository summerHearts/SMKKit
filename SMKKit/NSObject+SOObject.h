//
//  NSObject+SOObject.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (SOObject)

- (BOOL)smk_isNotEmpty;

- (void)smk_setAssociateValue:(id)value withKey:(void *)key; // Strong reference

- (void)smk_setAssociateWeakValue:(id)value withKey:(void *)key;

- (void)smk_setAssociateCopyValue:(id)value withKey:(void *)key;

- (id)smk_associatedValueForKey:(void *)key;
@end


