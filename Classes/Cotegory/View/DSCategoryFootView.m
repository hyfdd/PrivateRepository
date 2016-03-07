//
//  DSCategoryFootView.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/15.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSCategoryFootView.h"

@interface DSCategoryFootView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation DSCategoryFootView

- (void)awakeFromNib{
    UIImage *image = [UIImage imageNamed:@"board_bottom.9"];
    CGFloat top = 1; // 顶端盖高度
    CGFloat bottom = 19 ; // 底端盖高度
    CGFloat left = 74; // 左端盖宽度
    CGFloat right = 76; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    _imgView.image = image;
}

@end
