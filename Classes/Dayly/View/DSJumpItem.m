//
//  DSJumpItem.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/28.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "DSJumpItem.h"
#import "UIImageView+AFNetworking.h"

@interface DSJumpItem ()

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation DSJumpItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, self.frame.size.width - 4, self.frame.size.width - 4)];
        _iconImageView.layer.cornerRadius = 6;
        _iconImageView.clipsToBounds = YES;
        [self addSubview:_iconImageView];
    }
    return self;
}


- (void)setIconUrl:(NSString *)iconUrl{
    _iconUrl = iconUrl;
    [_iconImageView setImageWithURL:[NSURL URLWithString:_iconUrl]];
}

@end
