//
//  DSCategoryCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/15.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSCategoryCell.h"
#import "DSCategoryApp.h"
#import "UIImageView+AFNetworking.h"

@interface DSCategoryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgoundImgView;


@end

@implementation DSCategoryCell

- (void)awakeFromNib {
    UIImage *image = [UIImage imageNamed:@"category_board_body.9"];
    NSInteger leftCapWidth = image.size.width * 0.5;
    NSInteger topCapHeight = image.size.height * 0.5;
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    _backgoundImgView.image = image;
}

- (void)setApp:(DSCategoryApp *)app{
    [self.iconView setImageWithURL:[NSURL URLWithString:app.iconUrl]];
    self.titleLabel.text = app.title;
    self.subTitleLabel.text = app.subTitle;
}


- (void)hideSeparator:(BOOL)hidden{
    _lineView.hidden = hidden;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // [super setSelected:selected animated:animated];
}

@end
