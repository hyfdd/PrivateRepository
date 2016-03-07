//
//  CommentCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/23.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "CommentCell.h"
#import "DSComment.h"
#import "UIImageView+AFNetworking.h"
#import "Helper.h"

@interface CommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *upTimesLabel;


@end

@implementation CommentCell

- (void)awakeFromNib {
    _headImageView.layer.cornerRadius = 22;
    _headImageView.clipsToBounds = YES;
    _headImageView.image = nil;
    _userNameLabel.text = @"";
    _contentLabel.text = @"";
    _upTimesLabel.text = @"0";
}

- (void)setComment:(DSComment *)comment{
    _comment = comment;
    [_headImageView setImageWithURL:[NSURL URLWithString:comment.author.avatarUrl]];
    _userNameLabel.text = comment.author.name;
    _contentLabel.text = comment.content;
    _userNameLabel.text = [NSString stringWithFormat:@"%ld", comment.upTimes];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
