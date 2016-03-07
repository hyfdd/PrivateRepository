//
//  ShareViewCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/10/6.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "ShareViewCell.h"
#import "HttpRequestManager.h"
#import "DSNewApp.h"
#import "MJRefresh.h"
#import "DSNewAppCell.h"
#import "UILabel+Alert.h"

@interface ShareViewCell ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView *footView;

@end

@implementation ShareViewCell
{
    NSInteger _currentPage;
    NSMutableArray *_dataArray;
    CGPoint _currentOffset;
    BOOL _refreshing;
    BOOL _hasNext;
}

- (void)awakeFromNib {
    _currentPage = 1;
    _hasNext = YES;
    _refreshing = NO;
    _dataArray = [NSMutableArray array];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"DSNewAppCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)setUserId:(NSNumber *)userId{
    _userId = userId;
    _currentPage = 1;
    [self loadDataFromNet];
}

- (void)loadDataFromNet{
    [[HttpRequestManager shareManger] getUserCommunityAppInfoWithId:_userId page:_currentPage success:^(id responseObject) {
        if (_currentPage == 1) {
            [_dataArray removeAllObjects];
        }
        NSDictionary *dic = responseObject;
        
        NSArray *array = dic[@"apps"];
        NSNumber *number = dic[@"has_next"];
        _hasNext = number.boolValue;
        for (NSDictionary *dict in array) {
            NSError *error = nil;
            DSNewApp *app = [[DSNewApp alloc] initWithDictionary:dict error:&error];
            [_dataArray addObject:app];
        }
        _refreshing = NO;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        UILabel *label = [[UILabel alloc] initWithMessage:@"获取用户推荐数据失败"];
        [label showInView:self];
    }];
}

#pragma mark - UITableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DSNewAppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.app = _dataArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121 + (SCREEN_WIDTH - 20) * 169 / 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_refreshing && _hasNext) {
        return 50;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_footView.bounds.size.width * 0.5 - 10, 12, 20, 20)];
    NSMutableArray *loadImages = [NSMutableArray array];
    for (int i = 1; i < 9; i++) {
        [loadImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_%d", i]]];
    }
    imageView.animationImages = loadImages;
    imageView.animationRepeatCount = 0;
    [imageView startAnimating];
    [_footView addSubview:imageView];
    return _footView;
}


#pragma mark - UIScrollView代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 0) {
        if ([_delegate respondsToSelector:@selector(cellDidScrollDown:)]) {
            [_delegate cellDidScrollUp:nil];
        }
    }else {
        if ([_delegate respondsToSelector:@selector(cellDidScrollUp:)]) {
            [_delegate cellDidScrollDown:nil];
        }
    }
    _currentOffset = scrollView.contentOffset;
    if (scrollView.contentOffset.y > scrollView.contentSize.height - self.bounds.size.height + 44 && _refreshing == NO) {
        if (_hasNext == NO) {
            return;
        }
        _currentPage ++;
        _refreshing = YES;
        [self.tableView reloadData];
        [self loadDataFromNet];
    }
}

@end
