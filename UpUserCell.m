//
//  UpUserCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/23.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "UpUserCell.h"
#import "DSDaylyApp.h"
#import "UIImageView+AFNetworking.h"

@implementation UpUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setApp:(DSDaylyApp *)app {
    self.backgroundColor = [UIColor lightGrayColor];
    NSInteger count = 0;
    CGFloat space = 8;
    CGFloat buttonW = (SCREEN_WIDTH - 48 - 36) / 7;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 7; j++) {
            DSUser *user = app.upUsers[count];
            UIImageView *headImageView = [[UIImageView alloc] init];
            headImageView.frame = CGRectMake(18 + j * (buttonW + space), i * (buttonW + space), buttonW, buttonW);
            [headImageView setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
            headImageView.layer.cornerRadius = buttonW * 0.5;
            headImageView.clipsToBounds = YES;
            headImageView.userInteractionEnabled = YES;
            [self addSubview:headImageView];
            count++;
            if (count == 13 || count == app.upUsers.count) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(18 + (j+1) * (buttonW + space), i * (buttonW + space), buttonW, buttonW);
                [button setBackgroundImage:[UIImage imageNamed:@"forum_icon_more_normal"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"forum_icon_more_pressed"] forState:UIControlStateHighlighted];
                [self addSubview:button];
                return;
            }
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
