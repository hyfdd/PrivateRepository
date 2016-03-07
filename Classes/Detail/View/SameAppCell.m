//
//  SameAppCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/23.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "SameAppCell.h"
#import "DSSameApp.h"
#import "UIImageView+AFNetworking.h"

@interface SameAppCell ()

@property (weak, nonatomic) IBOutlet UILabel *flowerNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authorHeadView;
@property (weak, nonatomic) IBOutlet UILabel *authotNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *degistLabel;


@end

@implementation SameAppCell

- (void)awakeFromNib {
    // Initialization code
    _authorHeadView.layer.cornerRadius = 18;
    _authorHeadView.clipsToBounds = YES;
}

- (void)setApp:(DSSameApp *)app{
    _app = app;
    _flowerNumLabel.text = [NSString stringWithFormat:@"%ld", app.upTimes];
    [_authorHeadView setImageWithURL:[NSURL URLWithString:app.author.avatarUrl]];
    _authotNameLabel.text = app.author.name;
    _degistLabel.text = app.digest;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
