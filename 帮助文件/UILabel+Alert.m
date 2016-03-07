//
//  UILabel+Alert.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/15.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "UILabel+Alert.h"

@implementation UILabel (Alert)

- (instancetype)initWithMessage:(NSString *)message{
    if ( self = [super init]) {
        // self.frame = CGRectMake(SCREEN_WIDTH * 0.25, SCREEN_WIDTH * 0.25 + 20, SCREEN_WIDTH *0.5, 30);
        self.text = message;
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor lightGrayColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.alpha = 0;
    }
    return self;
}

- (void)showInView:(UIView *)view{
    CGFloat w = 200;
    CGFloat h = 30;
    CGFloat x = (view.frame.size.width - w) * 0.5;
    CGFloat y = (view.frame.size.height - h) * 0.5;
    self.frame = CGRectMake(x, y, w, h);
    [view addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:0.5 delay:1 options:0 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

@end
