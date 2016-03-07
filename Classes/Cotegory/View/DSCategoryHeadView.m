//
//  DSCategoryHeadView.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/15.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSCategoryHeadView.h"
#import "UIImageView+AFNetworking.h"
#import "DSCatgoryGroup.h"
#import "HttpRequestManager.h"
#import "UILabel+Alert.h"
#import "DSCategoryApp.h"
#import "DSMoreViewController.h"

@interface DSCategoryHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *bottomImage;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation DSCategoryHeadView

- (void)awakeFromNib{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMore:)];
    [self addGestureRecognizer:tap];
    UIImage *image = [UIImage imageNamed:@"board_top.9"];
    CGFloat top = 18; // 顶端盖高度
    CGFloat bottom = 20 ; // 底端盖高度
    CGFloat left = 74; // 左端盖宽度
    CGFloat right = 76; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    _bottomImage.image = image;
}

- (void)showMore:(UITapGestureRecognizer *)tap{
    DSMoreViewController *moreVC = [[DSMoreViewController alloc] initWithNibName:@"DSMoreViewController" bundle:nil];
    moreVC.groupID = _group.groupId;
    moreVC.backTitle = _group.title;
    if ([_delegate respondsToSelector:@selector(showMore:)]) {
        [_delegate showMore:moreVC];
    }
}


- (void)setGroup:(DSCatgoryGroup *)group{
    _group = group;
    [_iconImage setImageWithURL:[NSURL URLWithString:group.iconUrl]];
    _titleLabel.text = group.title;
    
}

@end
