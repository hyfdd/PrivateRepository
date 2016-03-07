//
//  CollectAppCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/10/8.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "CollectAppCell.h"
#import "DSCollectApp.h"
#import "UIImageView+AFNetworking.h"

@interface CollectAppCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceMsgLabel;
@property (weak, nonatomic) IBOutlet UILabel *flowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *commectsLabel;

@end

@implementation CollectAppCell

- (void)awakeFromNib {
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.iconImageView.image = nil;
    self.titleLabel.text = @"";
    self.sourceMsgLabel.text = @"";
    self.flowersLabel.text = @"";
    self.commectsLabel.text = @"";
}

- (void)setApp:(DSCollectApp *)app{
    _app = app;
    [_iconImageView setImageWithURL:[NSURL URLWithString:app.icon]];
    _titleLabel.text = app.title;
    _sourceMsgLabel.text = app.sourceMsg;
    _flowersLabel.text = [NSString stringWithFormat:@"%@", app.upTimes];
    _commectsLabel.text = [NSString stringWithFormat:@"%@", app.commentTimes];
}

@end
