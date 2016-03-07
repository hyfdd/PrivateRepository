//
//  DSNewCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/18.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSNewCell.h"
#import "MJRefresh.h"
#import "HttpRequestManager.h"
#import "DSNewApp.h"
#import "DSBestAppCell.h"
#import "DSNewAppCell.h"
#import "DSUserRank.h"

@interface DSNewCell ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) MJRefreshHeaderView *header;
@property (nonatomic, strong) MJRefreshFooterView *footer;
@property (nonatomic, strong, readonly) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger pos;

@end

@implementation DSNewCell

- (void)awakeFromNib {
    _dataArray = [NSMutableArray array];
    _pos = -1;
    [self setSubViews];
}

- (void)setSubViews{
    [_tableView registerNib:[UINib nibWithNibName:@"DSNewAppCell" bundle:nil] forCellReuseIdentifier:@"DSNewAppCell"];
    _header = [[MJRefreshHeaderView alloc] initWithScrollView:_tableView];
    _footer = [[MJRefreshFooterView alloc] initWithScrollView:_tableView];
    _header.delegate = self;
    _footer.delegate = self;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self loadDiscoverNewDataFromNet];
}

- (void)loadDiscoverNewDataFromNet{
    [[HttpRequestManager shareManger] getNewAppInfoWithPos:_pos success:^(id responseObject) {
        if (_pos == -1) {
            [_dataArray removeAllObjects];
        }
        NSArray *array = responseObject;
        for (NSDictionary *dict in array) {
            NSError *error = nil;
            DSNewApp *app = [[DSNewApp alloc] initWithDictionary:dict error:&error];
            NSLog(@"%@", error);
            [_dataArray addObject:app];
        }
        [self.tableView reloadData];
        [_header endRefreshing];
        [_footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"请求数据失败error = %@", error);
    }];
}


#pragma mark - MJRefreshViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        _pos = -1;
        [self loadDiscoverNewDataFromNet];
    }else {
        DSNewApp *app = [_dataArray lastObject];
        _pos = app.pos;
        [self loadDiscoverNewDataFromNet];
    }
}

#pragma mark - UItableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DSNewAppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DSNewAppCell"];
    cell.app = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121 + (SCREEN_WIDTH - 20) * 169 / 300;
}

@end
