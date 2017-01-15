//
//  UIButton+SMK_Kit.m
//  SMKKit
//
//  Created by Kenvin on 16/1/10.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import "UIButton+SMK_Kit.h"
#import "NSObject+SOObject.h"

@implementation UIButton (SMK_Kit)

- (void)smk_handleClickBlock:(SMKButtonActionBlock)action {
    [self smk_handleControlEvents:UIControlEventTouchUpInside withBlock:action];
}

- (void)smk_handleControlEvents:(UIControlEvents)events withBlock:(SMKButtonActionBlock)action {
    [self smk_setAssociateCopyValue:action withKey:@selector(smk_handleControlEvents:withBlock:)];
    [self addTarget:self action:@selector(smk_buttonAction:) forControlEvents:events];
}

- (void)smk_buttonAction:(id)sender {
    SMKButtonActionBlock block = (SMKButtonActionBlock)[self smk_associatedValueForKey:@selector(smk_handleControlEvents:withBlock:)];
    if (block) {
        self.enabled = NO;
        block();
        self.enabled = YES;
    }
}

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        } else {
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

@end
