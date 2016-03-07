//
//  DiscoverCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/14.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DiscoverCell.h"
#import "HttpRequestManager.h"
#import "DSNewApp.h"
#import "DSBestAppCell.h"
#import "DSNewAppCell.h"
#import "MJRefresh.h"
#import "DSUserRank.h"

@interface DiscoverCell () <UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) MJRefreshHeaderView *header;
@property (nonatomic, strong) MJRefreshFooterView *footer;
@property (nonatomic, strong, readonly) NSMutableArray *dataArrayNew;
@property (nonatomic, strong, readonly) NSMutableArray *daraArrayUserRank;

@property (nonatomic, assign) NSInteger pos;

@end

@implementation DiscoverCell

- (void)awakeFromNib {
    _daraArrayUserRank = [NSMutableArray array];
    _dataArrayNew = [NSMutableArray array];
    _pos = -1;
    [self setSubViews];
    // Initialization code
    [_tableView registerNib:[UINib nibWithNibName:@"DSNewAppCell" bundle:nil] forCellReuseIdentifier:@"DSNewAppCell"];
    _header = [[MJRefreshHeaderView alloc] initWithScrollView:_tableView];
    _footer = [[MJRefreshFooterView alloc] initWithScrollView:_tableView];
    _header.delegate = self;
    _footer.delegate = self;
}

- (void)setDisCovertype:(DiscoverCellType)disCovertype{
    _disCovertype = disCovertype;
    switch (disCovertype) {
        case 0:
        {
            
            break;
        }
        case 1:
        {

            [self loadDiscoverNewDataFromNet];
            break;
        }
        case 3:
        {
            CGRect frame = _tableView.frame;
            UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
            _tableView = tableView;
            [self loadDiscoverFriendDataFromNet];
            break;
        }
        case 4:
        {
            
            break;
        }
            
        default:
            break;
    }
}

- (void)setSubViews{
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)loadDiscoverNewDataFromNet{
    [[HttpRequestManager shareManger] getNewAppInfoWithPos:_pos success:^(id responseObject) {
        if (_pos == -1) {
            [_dataArrayNew removeAllObjects];
        }
        NSArray *array = responseObject;
        for (NSDictionary *dict in array) {
            NSError *error = nil;
            DSNewApp *app = [[DSNewApp alloc] initWithDictionary:dict error:&error];
            NSLog(@"%@", error);
            [_dataArrayNew addObject:app];
        }
        [self.tableView reloadData];
        [_header endRefreshing];
        [_footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"请求数据失败error = %@", error);
    }];
}

- (void)loadDiscoverFriendDataFromNet{
    [[HttpRequestManager shareManger] getFriendRankInfoSuccess:^(id responseObject) {
        NSArray *ranks = responseObject;
        for (NSDictionary *dict in ranks) {
            NSError *error = nil;
            DSUserRank *rank = [[DSUserRank alloc] initWithDictionary:dict error:&error];
            if (error) {
                NSLog(@"JasonModel初始化美友排行数据失败%@", error);
            }else {
                [_daraArrayUserRank addObject:rank];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - MJRefreshViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        _pos = -1;
        [self loadDiscoverNewDataFromNet];
    }else {
        DSNewApp *app = [_dataArrayNew lastObject];
        _pos = app.pos;
        [self loadDiscoverNewDataFromNet];
    }
}

#pragma mark - UItableView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    switch (_disCovertype) {
        case 0:
        {
            break;
        }
        case 1:
        {
            break;
        }
        case 3:
        {
            return _daraArrayUserRank.count;
            break;
        }
        case 4:
        {
            break;
        }
            
        default:
            break;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (_disCovertype) {
        case 0:
        {
            break;
        }
        case 1:
        {
            return _dataArrayNew.count;
            break;
        }
        case 3:
        {
            DSUserRank *rank = _daraArrayUserRank[section];
            return rank.users.count;
            break;
        }
        case 4:
        {
            break;
        }
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DSNewAppCell *cell = nil;
    switch (_disCovertype) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DSNewAppCell"];
            break;
        }
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DSNewAppCell"];
            cell.app = _dataArrayNew[indexPath.row];
            break;
        }
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DSNewAppCell"];
            break;
        }
        case 4:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DSNewAppCell"];
            break;
        }
            
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight = 0.0;
    switch (_disCovertype) {
        case 0:
        {
            break;
        }
        case 1:
        {
            rowHeight = 121 + (SCREEN_WIDTH - 20) * 169 / 300;
            break;
        }
        case 3:
        {
            rowHeight = 121 + (SCREEN_WIDTH - 20) * 169 / 300;
            break;
        }
        case 4:
        {
            break;
        }
            
        default:
            break;
    }
    return rowHeight;
}

@end
