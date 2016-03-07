//
//  DSDaylyCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/16.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSDaylyCell.h"
#import "UIImageView+AFNetworking.h"
#import "DSDaylyApp.h"

@interface DSDaylyCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UIView *flowerView;
@property (weak, nonatomic) IBOutlet UILabel *flowerNumberLabel;

@end

@implementation DSDaylyCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    _flowerView.layer.borderWidth = 1;
    _flowerView.layer.borderColor = [UIColor colorWithRed:241/255.0 green:101/255.0 blue:81/255.0 alpha:1].CGColor;
    
}

- (void)setApp:(DSDaylyApp *)app{
    if (app == nil) {
        _imgView.image = nil;
    }
    _app = app;
    _titleLabel.text = app.title;
    _subTitleLabel.text = app.subTitle;
    [_imgView setImageWithURL:[NSURL URLWithString:app.coverImage]];
    _digestLabel.text = app.digest;
}

@end
