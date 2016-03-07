//
//  DSSidebarView.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/14.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSSidebarView.h"

@implementation DSSidebarView

- (void)awakeFromNib{
    _DotImageView.hidden = YES;
}

- (IBAction)clickSidebarButton {
    _DotImageView.hidden = NO;
}

@end
