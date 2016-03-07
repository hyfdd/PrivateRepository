//
//  DSMeiyouCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/17.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSMeiyouCell.h"
#import "DSUser.h"
#import "UIImageView+AFNetworking.h"
#import "Helper.h"

@interface DSMeiyouCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *flowersLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation DSMeiyouCell

- (void)awakeFromNib {
    _headImgView.layer.cornerRadius = 22;
    _headImgView.clipsToBounds = YES;
    _userNameLabel.text = @"";
    _subTitle.text = @"";
    _flowersLabel.text = @"";
    _vipImageView.hidden = YES;
    UIImage *image =[UIImage imageNamed:@"board_body.9"];
    _bgImgView.image = [Helper adjustCenterImageWithImage:image];
    _lineView.hidden = NO;
}

- (void)setUser:(DSUser *)user{
    _user = user;
    [_headImgView setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
    _userNameLabel.text = user.name;
    _subTitle.text = user.career;
    _flowersLabel.text = [NSString stringWithFormat:@"+%ld", user.flowers];
    _vipImageView.hidden = !user.identity;
}

- (void)setLast:(BOOL)last{
    _last = last;
    _lineView.hidden = last;
    UIImage *image1 = [UIImage imageNamed:@"board_ranking_bottom.9"];
    UIImage *image2 = [UIImage imageNamed:@"board_body.9"];
    UIImage *image = last ? image1 : image2;
    _bgImgView.image = [Helper adjustCenterImageWithImage:image];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
