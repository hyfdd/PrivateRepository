//
//  ContentCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/20.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "ContentCell.h"
#import "Helper.h"
#import "UIImageView+AFNetworking.h"

#define SPACE 18.0
#define TITLE_FONT [UIFont systemFontOfSize:22]
#define DETAIL_FONT [UIFont systemFontOfSize:16]
#define LABEL_WIDTH SCREEN_WIDTH - 30
#define IMAGE_WIDTH SCREEN_WIDTH - 4 * SPACE

@interface ContentCell ()

@property (assign, nonatomic) CGFloat currentHeight;

@end

@implementation ContentCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(NSString *)content{
    if ([_content isEqualToString:content]) {
        return;
    }else {
        _content = content;
    }
    NSArray *cells = [content componentsSeparatedByString:@"\n"];
    for (NSString *cell in cells) {
        [self analysisData:cell];
    }
}

- (void)analysisData:(NSString *)cell{
    if (cell.length < 1) {
        return;
    }
    NSString *firstThreeChars = [cell substringToIndex:3];
    
    if ([firstThreeChars isEqualToString:@"<h2"]) {
        // 如果是<h2开头,是小标题
        NSRange range = {4, cell.length - 9};
        NSString *title = [cell substringWithRange:range];
        
        // 创建标题label
        CGFloat titleLabelH = [Helper heightOfString:title font:TITLE_FONT width:LABEL_WIDTH];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE, _currentHeight, LABEL_WIDTH, titleLabelH)];
        titleLabel.numberOfLines = 0;
        titleLabel.text = title;
        titleLabel.font = TITLE_FONT;
        [self.contentView addSubview:titleLabel];
        _currentHeight += titleLabelH;
        _currentHeight += SPACE;
    }else if ([firstThreeChars isEqualToString:@"<p>"]) {
        // 如果是<p>开头,是文字描述或者图片
        NSRange range = {3, cell.length - 7};
        NSString *detail = [cell substringWithRange:range];
        
        if (detail.length < 1) {
            return;
        }
        // 再次判断是图片还是文字描述
        NSString *firstFourChars = [detail substringToIndex:4];
        if ([firstFourChars isEqualToString:@"<img"]) {
            // 图片
            [self analysisImageUrlsWithString:detail];
        }else {
            // 文字
            // 创建描述label
            CGFloat detailLabelH = [Helper heightOfString:detail font:DETAIL_FONT width:LABEL_WIDTH];
            UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE, _currentHeight, LABEL_WIDTH, detailLabelH)];
            detailLabel.numberOfLines = 0;
            detailLabel.text = detail;
            detailLabel.font = DETAIL_FONT;
            detailLabel.textColor = [UIColor darkGrayColor];
            [self.contentView addSubview:detailLabel];
            _currentHeight += detailLabelH;
            _currentHeight += SPACE;
        }
    }
}

- (void)analysisImageUrlsWithString:(NSString *)string{
    NSArray *imgUrls = [string componentsSeparatedByString:@"/>"];
    for (NSString *imgUrl in imgUrls) {
        // NSLog(@"imgUrl = %@", imgUrl);
        if (imgUrl.length < 9) {
            return;
        }
        NSRange range = [imgUrl rangeOfString:@"http"];
        NSString *s = [imgUrl substringFromIndex:range.location - 1];
        NSArray *imageinfos = [s componentsSeparatedByString:@" "];
        
        NSString *imageUrl;
        CGFloat width = 320;
        CGFloat height = 0.0;
        for (NSString *s in imageinfos) {
            if ([s rangeOfString:@"http"].location != NSNotFound) {
                // 图片地址链接
                NSRange r = {1, s.length - 2};
                imageUrl = [s substringWithRange:r];
                imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            else if ([s rangeOfString:@"width"].location != NSNotFound) {
                // 图片宽度
                NSRange r = {7, s.length - 8};
                width= [s substringWithRange:r].floatValue;
                // NSLog(@"%lf", width);
                if (width <= 0) {
                    return;
                }
            } else if ([s rangeOfString:@"height"].location != NSNotFound) {
                // 图片高度
                NSRange r = {8, s.length - 9};
                height = [s substringWithRange:r].floatValue;
                // NSLog(@"%lf", height);
                if (height <= 0) {
                    return;
                }
            }
        }
        // NSLog(@"%lf, %lf", width, height);
        CGFloat imageW = IMAGE_WIDTH;
        CGFloat imageH = height * imageW / width;
        CGFloat imageX = SPACE * 2;
        CGFloat imageY = _currentHeight;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        // NSLog(@"%lf, %lf, %lf, %lf", imageX, imageY, imageW, imageH);
        [imageView setImageWithURL:[NSURL URLWithString:imageUrl]];
        [self.contentView addSubview:imageView];
        _currentHeight += imageH;
        _currentHeight += SPACE;
    }
}

@end
