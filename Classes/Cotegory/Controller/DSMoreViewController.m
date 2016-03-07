//
//  DSMoreViewController.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/25.
//  Copyright © 2015年 王大帅. All rights reserved.
//

#import "DSMoreViewController.h"
#import "HttpRequestManager.h"
#import "DSCategoryApp.h"
#import "UILabel+Alert.h"
#import "DSCategoryCell.h"
#import "DSDetailController.h"
#import "DSDaylyApp.h"

@interface DSMoreViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *backLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic, readonly) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger currentPage;

@end

@implementation DSMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setViews];
    // [self loadDataFromNet];
}

- (void)setViews{
    self.navigationController.navigationBarHidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [_backView addGestureRecognizer:tap];
    _backLabel.text = _backTitle;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"DSCategoryCell" bundle:nil] forCellReuseIdentifier:@"DSCategoryCell"];
    
    _dataArray = [NSMutableArray array];
    _currentPage = 1;
    [self loadDataFromNet];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadDataFromNet{
    NSLog(@"_groupID = %@, _currentPage = %ld", _groupID, _currentPage);
    [[HttpRequestManager shareManger] getMoreAppInfoWithId:_groupID page:_currentPage success:^(id responseObject) {
        NSArray *array = responseObject;
        for (NSDictionary *dic in array) {
            DSCategoryApp *app = [[DSCategoryApp alloc] initWithDictionary:dic];
            [_dataArray addObject:app];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        UILabel *label = [[UILabel alloc] initWithMessage:@"获取网络数据失败"];
        [label showInView:self.view];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UItableViewDelegate&Datasourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DSCategoryCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DSCategoryCell"];
    cell.app = _dataArray[indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    // 在这里获取App详情数据,并推出新的视图
    DSCategoryApp *app = _dataArray[indexPath.row];
    [[HttpRequestManager shareManger] getAppInfoWithId:app.appid.integerValue success:^(id responseObject) {
        DSDaylyApp *newApp = [[DSDaylyApp alloc] initWithDictionary:responseObject error:nil];
        DSDetailController *detailVC = [[DSDetailController alloc] init];
        detailVC.app = newApp;
        
        [self.navigationController pushViewController:detailVC animated:YES];
    } failure:^(NSError *error) {
        UILabel *label = [[UILabel alloc] initWithMessage:@"获取数据失败"];
        [label showInView:self.view];
    }];
    return NO;
}

#pragma mark - 按钮点击事件


@end
