//
//  ShareCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/22.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "ShareCell.h"
#import "UIImageView+AFNetworking.h"
#import "DSDaylyApp.h"

@interface ShareCell ()

@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sharebgView;

@property (weak, nonatomic) IBOutlet UIButton *recomment;

@end

@implementation ShareCell

- (void)awakeFromNib {
    UIImage *bgImage = _sharebgView.image;
    CGFloat h = bgImage.size.height * 0.5;
    CGFloat w = bgImage.size.width * 0.25;
    bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(h, w * 3, h, w) resizingMode:UIImageResizingModeStretch];
    _sharebgView.image = bgImage;
    
    
    UIImage *btnImage = [UIImage imageNamed:@"button_lightblue_normal.9"];
    btnImage = [btnImage resizableImageWithCapInsets:UIEdgeInsetsMake(btnImage.size.height/2, btnImage.size.width/2, btnImage.size.height/2, btnImage.size.width/2) resizingMode:UIImageResizingModeStretch];
    [_recomment setBackgroundImage:btnImage forState:UIControlStateNormal];
}

- (void)setApp:(DSDaylyApp *)app{
    _app = app;
    [_iconImageView setImageWithURL:[NSURL URLWithString:app.iconImage]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
