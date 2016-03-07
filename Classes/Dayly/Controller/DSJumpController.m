//
//  DSJumpController.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/28.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "DSJumpController.h"
#import "DSJumpItem.h"
#import "DSDaylyApp.h"

@interface DSJumpController ()


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/// 复用的View
@property (nonatomic, strong, readonly) NSMutableArray *reusedItems;


/// 是否是触摸转态
@property (nonatomic, assign, getter=isTouching) BOOL touching;

/// 选中的图标下标
@property (nonatomic, assign) NSInteger selectdIndex;

/// 当前ScrollView上item数量
@property (nonatomic, assign) NSInteger items;

@end

@implementation DSJumpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)setApps:(NSArray *)apps{
    _apps = nil;
    _apps = [NSArray array];
    _apps = apps;
    CGFloat width = SCREEN_WIDTH / _iconNumber * apps.count;
    CGFloat height = width + 20;
    _scrollView.contentSize = CGSizeMake(width, height);
    
    if (_selectdIndex != 0) {
        CGPoint point = _scrollView.contentOffset;
        point.x += SCREEN_WIDTH / _iconNumber * 4;
        _scrollView.contentOffset = point;
        [self selectedNextItem];
    }else {
        for (UIView *view in _scrollView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    for (NSInteger i = _selectdIndex; i < apps.count; i++) {
        CGFloat itemW = (SCREEN_WIDTH / _iconNumber) - _space;
        CGFloat itemH = itemW + 50;
        CGFloat itemX = _space * 0.5 + SCREEN_WIDTH / _iconNumber * i;
        CGFloat itemY = 10;
        DSJumpItem *item = [[DSJumpItem alloc] initWithFrame:CGRectMake(itemX, itemY, itemW, itemH)];
        item.tag = 100 + i;
        DSDaylyApp *app = apps[i];
        item.iconUrl = app.iconImage;
        if (i != _selectdIndex) {
            item.transform = CGAffineTransformMakeTranslation(0, 44);
        }
        
        [self.scrollView addSubview:item];
        item.backgroundColor = [UIColor whiteColor];
    }
    [self refreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)selectItemAtIndex:(NSInteger)index{
    _touching = NO;
    if (_selectdIndex != index) {
        _selectdIndex = index;
        [self refreshView];
    }
}

- (void)selectedNextItem{
    _selectdIndex = _selectdIndex + 1 < _apps.count ? _selectdIndex + 1 : 0;
    [self refreshView];
}

- (void)selectedpreviousItem{
    _selectdIndex = _selectdIndex - 1 >= 0 ? _selectdIndex - 1 : 0;
    [self refreshView];
}

- (void)refreshView{
    if (_touching) {
        for (UIView *view in _scrollView.subviews) {
            NSInteger offset = _selectdIndex > view.tag - 100 ? _selectdIndex - view.tag + 100 : view.tag - 100 - _selectdIndex;
            if (view.transform.ty < 8 * offset) {
                [UIView animateWithDuration:0.1 animations:^{
                    view.transform = CGAffineTransformMakeTranslation(0, 8 * offset - 5);
                }completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        view.transform = CGAffineTransformMakeTranslation(0, 8 * offset);
                    }];
                }];
            }else if (view.transform.ty > 8 * offset) {
                [UIView animateWithDuration:0.1 animations:^{
                    view.transform = CGAffineTransformMakeTranslation(0, 8 * offset + 5);
                }completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        view.transform = CGAffineTransformMakeTranslation(0, 8 * offset);
                    }];
                }];
            }
        }
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            if (_selectdIndex >= 3 && _selectdIndex <= _apps.count - 4) {
                _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH / _iconNumber * (_selectdIndex - 3), 0);
            }else if (_selectdIndex < 3) {
                _scrollView.contentOffset = CGPointMake(0, 0);
            }else {
                _scrollView.contentOffset = CGPointMake(_scrollView.contentSize.width - SCREEN_WIDTH, 0);
            }
        }];
        
        for (UIView *view in _scrollView.subviews) {
            if (view.tag == _selectdIndex + 100) {
                [UIView animateWithDuration:0.1 animations:^{
                    view.transform = CGAffineTransformMakeTranslation(0, 0);
                }];
            } else {
                [UIView animateWithDuration:0.1 animations:^{
                    view.transform = CGAffineTransformMakeTranslation(0, 44);
                }];
            }
        }
    }
}


#pragma mark --
#pragma mark - UItouch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.scrollView];
    _touching = YES;
    _selectdIndex = point.x / (SCREEN_WIDTH / 7);
    if (_selectdIndex < 0) {
        _selectdIndex = 0;
    }else if (_selectdIndex >= _apps.count){
        _selectdIndex = _apps.count - 1;
    }
    [self refreshView];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"触摸移动中");
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.scrollView];
    NSInteger index = point.x / (SCREEN_WIDTH / 7);
    if (index < 0) {
        index = 0;
    }else if (index >= _apps.count){
        index = _apps.count - 1;
    }
    if (index != _selectdIndex) {
        _selectdIndex = index;
        [self refreshView];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"触摸结束");
    _touching = NO;
    [self refreshView];
    if ([_delegate respondsToSelector:@selector(jumpControllerDidSelectedItemAtIndex:)]) {
        [_delegate jumpControllerDidSelectedItemAtIndex:_selectdIndex];
    }
}

@end
