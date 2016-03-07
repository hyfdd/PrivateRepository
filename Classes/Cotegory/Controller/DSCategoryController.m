//
//  DSCategoryController.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/15.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSCategoryController.h"
#import "DSDrawerController.h"
#import "DSCategoryCell.h"
#import "DSCatgoryGroup.h"
#import "DSCategoryApp.h"
#import "HttpRequestManager.h"
#import "UILabel+Alert.h"
#import "DSCategoryHeadView.h"
#import "DSCategoryFootView.h"
#import "DSDetailController.h"
#import "DSDaylyApp.h"
#import "AppDelegate.h"

@interface DSCategoryController () <UITableViewDataSource, UITableViewDelegate, DSCategoryHeadViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic, readonly) NSMutableArray *dataArray;

@end

@implementation DSCategoryController

- (instancetype)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle{
    if (self = [super initWithNibName:name bundle:bundle]) {
        _dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubViews];
    [self loadDataFromNet];
}

- (void)setSubViews{
    self.navigationController.navigationBarHidden = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"DSCategoryCell" bundle:nil] forCellReuseIdentifier:@"DSCategoryCell"];
}

- (void)loadDataFromNet{
    [[HttpRequestManager shareManger] getCategoryInfoSuccess:^(id responseObject) {
        NSArray *array = responseObject;
        for (NSDictionary *dic in array) {
            DSCatgoryGroup *group = [DSCatgoryGroup groupWithDictionary:dic];
            [_dataArray addObject:group];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        UILabel *label = [[UILabel alloc] initWithMessage:@"获取分类数据失败"];
        [label showInView:self.view];
    }];
}

#pragma mark - UItableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DSCatgoryGroup *group = _dataArray[section];
    return group.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DSCatgoryGroup *group = _dataArray[indexPath.section];
    DSCategoryApp *app = group.apps[indexPath.row];
    DSCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DSCategoryCell"];
    cell.app = app;
    if (indexPath.row == group.apps.count - 1) {
        [cell hideSeparator:YES];
    }else {
        [cell hideSeparator:NO];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{\
    DSCategoryHeadView *view = [[NSBundle mainBundle] loadNibNamed:@"DSCategoryHeadView" owner:self options:0][0];
    view.delegate = self;
    view.group = _dataArray[section];
    return view;
}

- (void)showMore:(UIViewController *)moreVC{
    moreVC.view.backgroundColor = self.view.backgroundColor;
    moreVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = delegate.window;
    window.backgroundColor = self.view.backgroundColor;
    [self.navigationController pushViewController:moreVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    DSCategoryFootView *view = [[NSBundle mainBundle] loadNibNamed:@"DSCategoryFootView" owner:self options:0][0];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15.0;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"第%ld组第%ld个", indexPath.section, indexPath.row);
    DSCatgoryGroup *group = _dataArray[indexPath.section];
    DSCategoryApp *app = group.apps[indexPath.row];
    [[HttpRequestManager shareManger] getAppInfoWithId:app.appid.integerValue success:^(id responseObject) {
        DSDaylyApp *newApp = [[DSDaylyApp alloc] initWithDictionary:responseObject error:nil];
        DSDetailController *detailVC = [[DSDetailController alloc] init];
        detailVC.app = newApp;
        static int num = 0;
        if (num == 0) {
            [self.navigationController pushViewController:detailVC animated:YES];
            num++;
        } else {
            num = 0;
        }
    } failure:^(NSError *error) {
        UILabel *label = [[UILabel alloc] initWithMessage:@"获取数据失败"];
        [label showInView:self.view];
    }];
    return NO;
}

#pragma mark - 按钮点击事件
- (IBAction)showMenuController {
    [self.drawerVC showMenuViewController];
}


#pragma mark - 收到内存警告调用
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
