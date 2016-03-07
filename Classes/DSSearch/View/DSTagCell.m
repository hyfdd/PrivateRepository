//
//  DSTagCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/10/9.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "DSTagCell.h"
#import "DSTag.h"

@implementation DSTagCell

- (void)setModel:(DSTag *)model{
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    [self addSubview:label];
    label.text = model.title;
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
}

@end
