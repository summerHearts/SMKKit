//
//  NSObject+SMK_AppInfo.h
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SMK_AppInfo)

-(NSString *)smk_version;

-(NSInteger)smk_build;

-(NSString *)smk_identifier;

-(NSString *)smk_currentLanguage;

-(NSString *)smk_deviceModel;
@end
