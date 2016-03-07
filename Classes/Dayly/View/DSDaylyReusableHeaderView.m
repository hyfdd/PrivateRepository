//
//  DSDaylyReusableView.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/16.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSDaylyReusableHeaderView.h"

@interface DSDaylyReusableHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *loadImgView;

@end

@implementation DSDaylyReusableHeaderView

- (void)awakeFromNib {
    NSMutableArray *loadImages = [NSMutableArray array];
    for (int i = 1; i < 9; i++) {
        [loadImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_%d", i]]];
    }
    _loadImgView.animationImages = loadImages;
    _loadImgView.animationRepeatCount = 0;
    [_loadImgView startAnimating];
}

@end
