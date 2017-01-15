//
//  MikeAlertView.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "BlockAlertView.h"
@interface BlockAlertView()
//http://blog.devtang.com/blog/2013/07/28/a-look-inside-blocks/ 唐巧关于block的讲解
@property(copy,nonatomic)void (^cancelClicked)();

@property(copy,nonatomic)void (^confirmClicked)();

//@property (copy, nonatomic)void (^confirmClicked)(NSString *plainText);

@end
@implementation BlockAlertView

-(id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelblock confirmButtonWithTitle:(NSString *)confirmTitle confrimBlock:(void (^)())confirmBlock{
    self=[super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:confirmTitle, nil];
    if (self) {
        //block属性的声明，首先需要用copy修饰符，因为只有copy后的block才会在堆中，栈中的block的生命周期是和栈绑定的
        //在声明block属性时需要确认“在调用block时另一个线程有没有可能去修改block？”这个问题，如果确定不会有这种情况发生的话，那么block属性声明可以用nonatomic。如果不肯定的话（通常情况是这样的），那么你首先需要声明block属性为atomic，也就是先保证变量的原子性
        //如果不加copy属性，当其所在栈被释放的时候，这些本地变量将变得不可访问。一旦代码执行到block这段就会导致bad access。
        _cancelClicked=[cancelblock copy];
        _confirmClicked=[confirmBlock copy];
    }
    return self;
}

+(void)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonWithTitle:(NSString *)cancelTitle cancelBlock:(void (^)())cancelblock confirmButtonWithTitle:(NSString *)confirmTitle confrimBlock:(void (^)())confirmBlock{
    BlockAlertView *alert=[[BlockAlertView alloc]initWithTitle:title message:message cancelButtonWithTitle:cancelTitle cancelBlock:cancelblock confirmButtonWithTitle:confirmTitle confrimBlock:confirmBlock];
    [alert show];
}


#pragma -mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.cancelButtonIndex != buttonIndex) {
        if (self.confirmClicked) {
                self.confirmClicked();
        }
    }else {
        if (self.cancelClicked) {
            self.cancelClicked();
        }
    }
}
@end
