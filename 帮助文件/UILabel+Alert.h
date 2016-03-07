//
//  UILabel+Alert.h
//  ZuiMei
//
//  Created by 王大帅 on 15/9/15.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Alert)

- (instancetype)initWithMessage:(NSString *)message;

- (void)showInView:(UIView *)view;

@end
