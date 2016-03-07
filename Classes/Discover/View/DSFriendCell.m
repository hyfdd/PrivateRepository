//
//  DSFriendCell.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/18.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSFriendCell.h"
#import "HttpRequestManager.h"
#import "DSUserRank.h"
#import "DSMeiyouCell.h"
#import "Helper.h"
#import "DSUserController.h"

@interface DSFriendCell () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong, readonly) NSMutableArray *dataArray;

@end

@implementation DSFriendCell

- (void)awakeFromNib {
    _dataArray = [NSMutableArray array];
    [self setSubViews];
}

- (void)setSubViews{
    [_tableView registerNib:[UINib nibWithNibName:@"DSMeiyouCell" bundle:nil] forCellReuseIdentifier:@"DSMeiyouCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self loadDiscoverFriendDataFromNet];
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
                [_dataArray addObject:rank];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UItableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DSUserRank *rank = _dataArray[section];
    return rank.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DSMeiyouCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DSMeiyouCell"];
    DSUserRank *rank = _dataArray[indexPath.section];
    cell.numLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    cell.user = rank.users[indexPath.row];
    if (indexPath.row == rank.users.count - 1) {
        cell.last = YES;
    }else{
        cell.last = NO;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 54)];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:view.frame];
    UIImage *image = [UIImage imageNamed:@"board_ranking_title.9"];
    bgImgView.image = [Helper adjustCenterImageWithImage:image];
    [view addSubview:bgImgView];
    
    DSUserRank *rank = _dataArray[section];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 280, 14)];
    titleLabel.text = rank.name;
    [view addSubview:titleLabel];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DSUserRank *rank = _dataArray[indexPath.section];
    if (rank.users.count - 1 == indexPath.row) {
        return 65;
    }
    return 60;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    DSUserController *userVC = [[DSUserController alloc] initWithNibName:@"DSUserController" bundle:nil];
    DSUserRank *rank = _dataArray[indexPath.section];
    DSUser *user = rank.users[indexPath.row];
    userVC.user = user;
    if ([_delegate respondsToSelector:@selector(pushViewController:)]) {
        [_delegate pushViewController:userVC];
    }
    
    return NO;
}

@end
