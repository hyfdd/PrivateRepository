//
//  DSNewAppCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/17.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSNewAppCell.h"
#import "DSNewApp.h"
#import "UIImageView+AFNetworking.h"

@interface DSNewAppCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UILabel *flowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *browerLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImgView;

@end

@implementation DSNewAppCell

- (void)awakeFromNib {
    _coverImgView.contentMode = UIViewContentModeScaleAspectFill;
    _coverImgView.clipsToBounds = YES;
    UIImage *image = [UIImage imageNamed:@"forum_tab_selected.9"];
    NSInteger leftCapWidth = image.size.width * 0.5;
    NSInteger topCapHeight = image.size.height * 0.5;
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    _bgImgView.image = image;
    
    _bgImgView.layer.cornerRadius = 3;
    _bgImgView.clipsToBounds = YES;
    
    _userHeadImgView.layer.cornerRadius = 15;
    _userHeadImgView.clipsToBounds = YES;
    _iconImgView.image = nil;
    _titleLabel.text = nil;
    _subTitleLabel.text = nil;
    _coverImgView.image = nil;
    _flowerLabel.text = @"0";
    _browerLabel.text = @"0";
    _commentLabel.text = @"0";
    _userNameLabel.text = nil;
    _userHeadImgView.image = nil;
}

- (void)setApp:(DSNewApp *)app{
    _app = app;
    [_iconImgView setImageWithURL:[NSURL URLWithString:app.iconImage]];
    _titleLabel.text = app.title;
    _subTitleLabel.text = app.subTitle;
    [_coverImgView setImageWithURL:[NSURL URLWithString:app.coverImage]];
    _flowerLabel.text = [NSString stringWithFormat:@"%ld", app.upTimes];
    _browerLabel.text = [NSString stringWithFormat:@"%ld", app.showTimes];
    _commentLabel.text = [NSString stringWithFormat:@"%ld", app.commentTimes];
    _userNameLabel.text = app.authorName;
    [_userHeadImgView setImageWithURL:[NSURL URLWithString:app.authorAvatarUrl]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
