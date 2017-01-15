//
//  SMKInputAccessoryView.m
//  SMKKit
//
//  Created by Kenvin on 16/3/19.
//  Copyright © 2016年 上海方创金融服务信息股份有限公司. All rights reserved.
//

#import "SMKInputAccessoryView.h"

@interface SMKInputAccessoryView ()

@property (nonatomic, strong) UIBarButtonItem *itemLast;
@property (nonatomic, strong) UIBarButtonItem *itemNext;
@property (nonatomic, strong) UIBarButtonItem *itemDone;
@end

@implementation SMKInputAccessoryView

#pragma mark - click methods
- (void)clickLast {
    if ([self.lastFirstResponder canBecomeFirstResponder]) {
        [self.lastFirstResponder becomeFirstResponder];
    }
}

- (void)clickNext {
    if ([self.nextFirstResponder canBecomeFirstResponder]) {
        [self.nextFirstResponder becomeFirstResponder];
    }
}

- (void)clickDone {
    if (self.doneBlock) {
        self.doneBlock();
    }
    
    if ([self.targert canResignFirstResponder]) {
        [self.targert resignFirstResponder];
    }
}

#pragma mark - getters/setters
- (void)setTargert:(UIResponder *)targert{
    _targert = targert;
    if (!targert) {
        [self removeAllObserver];
    }
}

#pragma mark - Life cycle
- (instancetype)initWithTargert:(UIResponder *)targert last:(id)lastFirstResponder next:(id)nextFirstResponder doneBlock:(void (^)(void))doneBlock {
    if (self = [super initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 44)]) {
        _targert = targert;
        _lastFirstResponder = lastFirstResponder;
        _nextFirstResponder = nextFirstResponder;
        _doneBlock = [doneBlock copy];
        
        [self commonInit];
        
        if ([targert isKindOfClass:[UITextField class]]) {
            [((UITextField *)targert) setInputAccessoryView:self];
        } else if ([targert isKindOfClass:[UITextView class]]) {
            [((UITextView *)targert) setInputAccessoryView:self];
        }
    }
    return self;
}

- (void)commonInit {
    UIImage *imageLast = [UIImage imageNamed:@"last"];
    UIImage *imageNext = [UIImage imageNamed:@"next"];
    
    if (imageLast && imageNext) {
        self.itemLast = [[UIBarButtonItem alloc] initWithImage:imageLast style:UIBarButtonItemStylePlain target:self action:@selector(clickLast)];
        self.itemNext = [[UIBarButtonItem alloc] initWithImage:imageNext style:UIBarButtonItemStylePlain target:self action:@selector(clickNext)];
    } else {
        self.itemLast = [[UIBarButtonItem alloc] initWithTitle:@"上一项" style:UIBarButtonItemStylePlain target:self action:@selector(clickLast)];
        self.itemNext = [[UIBarButtonItem alloc] initWithTitle:@"下一项" style:UIBarButtonItemStylePlain target:self action:@selector(clickNext)];
    }
    
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.itemDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(clickDone)];
    
    if (imageLast && imageNext) {
        [self setItems:@[self.itemLast, itemSpace, self.itemNext, itemSpace, itemSpace, itemSpace, itemSpace, self.itemDone]];
    } else {
        [self setItems:@[self.itemLast, self.itemNext, itemSpace, self.itemDone]];
    }
    
    self.itemLast.enabled = self.lastFirstResponder != nil;
    self.itemNext.enabled = self.nextFirstResponder != nil;
    
    [self addObserver:self forKeyPath:@"lastFirstResponder" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"nextFirstResponder" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
}

- (void)removeAllObserver {
    [self removeObserver:self forKeyPath:@"lastFirstResponder"];
    [self removeObserver:self forKeyPath:@"nextFirstResponder"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"lastFirstResponder"]) {
        self.itemLast.enabled = self.lastFirstResponder != nil;
        return;
    }
    
    if ([keyPath isEqualToString:@"nextFirstResponder"]) {
        self.itemNext.enabled = self.nextFirstResponder != nil;
        return;
    }
}

- (void)dealloc {
    [self removeAllObserver];
    
#ifdef DEBUG
    NSLog(@"[%@ %s]", [self.class description], sel_getName(_cmd));
#endif
    
}
@end
