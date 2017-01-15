//
//  UITextField+SMKLimit.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "UITextField+SMKLimit.h"
#import <objc/runtime.h>

@implementation UITextField (SMKLimit)
/*
 使用static用于函数定义时，对函数的连接方式产生影响，使得函数只在本文件内部有效，对其他文件是不可见的。这样的函数又叫作静态函数。使用静态函数的好处是，不用担心与其他文件的同名函数产生干扰，另外也是对函数本身的一种保护机制。
 　　
 　　如果想要其他文件可以引用本地函数，则要在函数定义时使用关键字extern，表示该函数是外部函数，可供其他文件调用。另外在要引用别的文件中定义的外部函数的文件中，使用extern声明要用的外部函数即可。
 */
static void *smkLimitMaxLengthKey = &smkLimitMaxLengthKey;

- (void)setSmk_maxLength:(NSUInteger)smk_maxLength{
    
    /*
     创建关联要使用到Objective-C的运行时函数：objc_setAssociatedObject来把一个对象与另外一个对象进行关联。该函数需要四个参数：源对象，关键字，关联的对象和一个关联策略。当然，此处的关键字和关联策略是需要进一步讨论的。
     ■  关键字是一个void类型的指针。每一个关联的关键字必须是唯一的。通常都是会采用静态变量来作为关键字。
     ■  关联策略表明了相关的对象是通过赋值，保留引用还是复制的方式进行关联的；还有这种关联是原子的还是非原子的。这里的关联策略和声明属性时的很类似。这种关联策略是通过使用预先定义好的常量来表示的。
     */
    objc_setAssociatedObject(self, smkLimitMaxLengthKey, @(smk_maxLength), OBJC_ASSOCIATION_COPY);
    
    
    if (smk_maxLength > 0) {
        [self addTarget:self action:@selector(_smk_valueChanged:) forControlEvents:UIControlEventAllEditingEvents];
    } else {
        [self removeTarget:self action:@selector(_smk_valueChanged:) forControlEvents:UIControlEventAllEditingEvents];
    }

}

//动态绑定
- (NSUInteger)smk_maxLength{
    return [objc_getAssociatedObject(self, smkLimitMaxLengthKey) unsignedIntegerValue];
}
#pragma mark - private
- (void)_smk_valueChanged:(UITextField *)textField {
    if (self.smk_maxLength == 0) {
        return;
    }
    
    NSUInteger currentLength = [textField.text length];
    if (currentLength <= self.smk_maxLength) {
        return;
    }
    //主线程中进行操作
    NSString *subString = [textField.text substringToIndex:self.smk_maxLength];
    dispatch_async(dispatch_get_main_queue(), ^{
        textField.text = subString;
        /*
         - (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
         - (void)sendActionsForControlEvents:(UIControlEvents)controlEvents;              
         事件与操作的区别：事件报告对屏幕的触摸；操作报告对控件的操纵。
         */
        [textField sendActionsForControlEvents:UIControlEventEditingChanged];
    });
}

@end
