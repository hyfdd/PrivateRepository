//
//  DetailDescCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/21.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "DetailDescCell.h"
#import "DSDaylyApp.h"
#import "UIImageView+AFNetworking.h"
#import "Helper.h"

@interface DetailDescCell ()

// 约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *first;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *second;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *three;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *last;



@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *downLoadLabel;



@end

@implementation DetailDescCell

- (void)awakeFromNib {
    _downLoadLabel.hidden = NO;
    _downloadButton.hidden = NO;
}

- (void)setApp:(DSDaylyApp *)app{
    _app = app;
    [_iconView setImageWithURL:[NSURL URLWithString:app.iconImage]];
    _titleLabel.text = app.title;
    _subTitleLabel.text = app.subTitle;
    _descLabel.text = app.digest;
    
    if ([app.downloadUrl isEqualToString:@""]) {
        _downloadButton.hidden = YES;
        _downLoadLabel.hidden = YES;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)heightWithApp:(DSDaylyApp *)app{
    CGFloat descLabelH = [Helper heightOfString:app.digest font:[UIFont systemFontOfSize:16] width:SCREEN_WIDTH - 36];
    return 131 + descLabelH + 10;
}

- (IBAction)collect {
    
}
- (IBAction)share {
    
}
- (IBAction)download {
    
}


@end
