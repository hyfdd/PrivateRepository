//
//  CollectFootView.m
//  ZuiMei
//
//  Created by 王大帅 on 15/10/9.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "CollectFootView.h"

@interface CollectFootView ()

@property (weak, nonatomic) IBOutlet UIImageView *loadImageView;

@end

@implementation CollectFootView

- (void)awakeFromNib {
    NSMutableArray *loadImages = [NSMutableArray array];
    for (int i = 1; i < 9; i++) {
        [loadImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_%d", i]]];
    }
    _loadImageView.animationImages = loadImages;
    _loadImageView.animationRepeatCount = 0;
    [_loadImageView startAnimating];
}

@end
