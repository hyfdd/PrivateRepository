//
//  DSDetailController.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/14.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import "DSDetailController.h"
#import "UILabel+Alert.h"
#import "HttpRequestManager.h"
#import "DSDaylyApp.h"
#import "UIImageView+AFNetworking.h"
#import "ContentCell.h"
#import "DetailDescCell.h"
#import "Helper.h"
#import "ShareCell.h"
#import "SameAppCell.h"
#import "UpUserCell.h"
#import "DSComment.h"
#import "CommentCell.h"
#import "MJRefresh.h"

@interface DSDetailController () <UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>

/// 返回按钮
@property (weak, nonatomic) IBOutlet UIButton *backButton;
/// 收藏按钮
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
/// 分享按钮
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/// 下载按钮
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;

/// tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/// 封面图片View
@property (nonatomic, strong) UIImageView *coverImageView;

/// 当前tableView偏移量
@property (nonatomic, assign) CGPoint currentContentOffset;
/// 当前contentInset
@property (nonatomic, assign) UIEdgeInsets currentContentInset;

/// 简述Cell
@property (nonatomic, weak) DetailDescCell *cell;

/// 底部工具及评论视图
@property (nonatomic, strong) UIView *bottomView;
/// 底部工具栏是否显示评论
@property (nonatomic, assign, getter=isShowComment) BOOL showComment;
/// 底部flower按钮
@property (nonatomic, strong) UIButton *flowerBtn;
/// 底部flower标签
@property (nonatomic, strong) UILabel *flowerLabel;
/// 底部leaf按钮
@property (nonatomic, strong) UIButton *leafBtn;

/// 评论列表的数据源
@property (nonatomic, strong) NSArray *comments;
/// 评论当前页数
@property (nonatomic, assign) NSInteger commentPage;

///
@property (nonatomic, weak) MJRefreshFooterView *footer;

@end

@implementation DSDetailController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _comments = [NSArray array];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _comments = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setSubViews];
}

- (void)loadCommentsFromNet{
    [[HttpRequestManager shareManger] getCommentInfoWithId:_app.id page:_commentPage success:^(id responseObject) {
        NSArray *array = responseObject[@"comments"];
        NSNumber *hasNext = responseObject[@"has_next"];
        for (NSDictionary *dict in array) {
            DSComment *comment = [[DSComment alloc] initWithDictionary:dict error:nil];
            _comments = [_comments arrayByAddingObject:comment];
        }
        [_tableView reloadData];
        [_footer endRefreshing];
        if (hasNext.intValue == 0) {
            [_footer free];
            [_footer removeFromSuperview];
        }
    } failure:^(NSError *error) {
        UILabel *label = [[UILabel alloc] initWithMessage:@"请求评论数据失败"];
        [label showInView:self.view];
        [_footer endRefreshing];
    }];
}

- (void)setSubViews{
    // 创建封面图片
    CGFloat coverImageHeight = SCREEN_WIDTH / 300 * 169;
    _tableView.contentInset = UIEdgeInsetsMake(coverImageHeight, 0, 0, 0);
    _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -coverImageHeight, SCREEN_WIDTH, coverImageHeight)];
    [_coverImageView setImageWithURL:[NSURL URLWithString:_app.coverImage]];
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:_coverImageView];
    [self.tableView sendSubviewToBack:_coverImageView];
    _coverImageView.autoresizesSubviews = YES;
    [self.view bringSubviewToFront:_backButton];
    
    // 设置tableView代理
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    // 注册cell复用
    [_tableView registerNib:[UINib nibWithNibName:@"DetailDescCell" bundle:nil] forCellReuseIdentifier:@"DetailDescCell"];
    [_tableView registerClass:[ContentCell class] forCellReuseIdentifier:@"ContentCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ShareCell" bundle:nil] forCellReuseIdentifier:@"ShareCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"SameAppCell" bundle:nil] forCellReuseIdentifier:@"SameAppCell"];
    [_tableView registerClass:[UpUserCell class] forCellReuseIdentifier:@"UpUserCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    
    // 创建底部视图
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH * 2 - 20, 44)];
    _bottomView.backgroundColor = [UIColor colorWithRed:229/255.0 green:232/255.0 blue:233/255.0 alpha:1];
    [self.view addSubview:_bottomView];
    
    UIButton *dragButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dragButton.frame = CGRectMake(SCREEN_WIDTH - 20, 11, 10, 22);
    [dragButton setBackgroundImage:[UIImage imageNamed:@"detail_icon_drag"] forState:UIControlStateNormal];
    [dragButton addTarget:self action:@selector(dragBottomView) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:dragButton];
    
    // 添加tools
    UIView *collectView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 5, SCREEN_WIDTH * 0.5 - 46, 34)];
    collectView.layer.cornerRadius = collectView.frame.size.height * 0.5;
    collectView.backgroundColor = [UIColor colorWithRed:251/255.0 green:115/255.0 blue:110/255.0 alpha:1];
    [_bottomView addSubview:collectView];
    
    _leafBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leafBtn.frame = CGRectMake(collectView.bounds.size.width - collectView.bounds.size.height * 0.5 - 18, 8, 18, 18);
    [_leafBtn setBackgroundImage:[UIImage imageNamed:@"detail_icon_leaf_normal"] forState:UIControlStateNormal];
    [_leafBtn setBackgroundImage:[UIImage imageNamed:@"detail_icon_leaf_pressed"] forState:UIControlStateSelected];
    [_leafBtn setBackgroundImage:[UIImage imageNamed:@"detail_icon_leaf_selected"] forState:UIControlStateSelected];
    [collectView addSubview:_leafBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(_leafBtn.frame.origin.x - 5, 5, 1, 24)];
    lineView.backgroundColor = [UIColor lightTextColor];
    [collectView addSubview:lineView];
    
    _flowerLabel = [[UILabel alloc] initWithFrame:CGRectMake(collectView.bounds.size.width/2 - 15, 8, 30, 18)];
    _flowerLabel.text = @"14";
    _flowerLabel.textAlignment = NSTextAlignmentCenter;
    _flowerLabel.font = [UIFont systemFontOfSize:14];
    _flowerLabel.textColor = [UIColor whiteColor];
    [collectView addSubview:_flowerLabel];
    
    _flowerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _flowerBtn.frame = CGRectMake(collectView.bounds.size.height * 0.5, 8, 18, 18);
    [_flowerBtn setBackgroundImage:[UIImage imageNamed:@"detail_icon_flower_normal"] forState:UIControlStateNormal];
    [_flowerBtn setBackgroundImage:[UIImage imageNamed:@"detail_icon_flower_pressed"] forState:UIControlStateSelected];
    [_flowerBtn setBackgroundImage:[UIImage imageNamed:@"detail_icon_flower_selected"] forState:UIControlStateSelected];
    [collectView addSubview:_flowerBtn];
    
    // 下载按钮
    UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    downloadBtn.frame = CGRectMake(SCREEN_WIDTH * 0.5 + 8, 5 , SCREEN_WIDTH * 0.5 - 46, 34);
    downloadBtn.layer.cornerRadius = 17;
    downloadBtn.backgroundColor = [UIColor colorWithRed:45/255.0 green:214/255.0 blue:235/255.0 alpha:1];
    [downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    [downloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    downloadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [downloadBtn setImage:[UIImage imageNamed:@"detail_icon_toolbar_download"] forState:UIControlStateNormal];
    [downloadBtn setTintColor:[UIColor whiteColor]];
    downloadBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 50, 10, 80);
    [_bottomView addSubview:downloadBtn];
    
    
    // 评论视图
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame = CGRectMake(SCREEN_WIDTH + 5, 5, SCREEN_WIDTH - 53, 34);
    commentBtn.backgroundColor = [UIColor whiteColor];
    commentBtn.layer.cornerRadius = 17;
    [_bottomView addSubview:commentBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(17, 5, commentBtn.frame.size.width - 34, 24)];
    label.text = @"写下你的评论吧!";
    label.textColor = [UIColor lightGrayColor];
    [commentBtn addSubview:label];
    
    
    
    // 设置刷新视图
    MJRefreshFooterView *footView = [[MJRefreshFooterView alloc] initWithScrollView:_tableView];
    footView.delegate = self;
    _footer = footView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MJRefreshViewDelegate

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    _commentPage ++;
    [self loadCommentsFromNet];
}

#pragma mark - UItableViewDataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_comments.count == 0) {
        return 3;
    }else{
        return 4;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return _app.sameApps.count;
    }else if (section == 3) {
        return _comments.count;
    }else {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DetailDescCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailDescCell"];
            cell.app = _app;
            cell.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
            _cell = cell;
            return cell;
        }else if (indexPath.row == 1) {
            ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCell"];
            cell.content = _app.content;
            cell.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
            return cell;
        }else if (indexPath.row == 2) {
            ShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareCell"];
            cell.app = _app;
            cell.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
            return cell;
        }else {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            return cell;
        }
    }else if (indexPath.section == 1) {
        SameAppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SameAppCell"];
        NSArray *sameApps = _app.sameApps;
        cell.app = sameApps[indexPath.row];
        cell.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        return cell;
    }else if (indexPath.section == 2) {
        UpUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UpUserCell"];
        cell.app = _app;
        cell.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        return cell;
    }else if (indexPath.section == 3) {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        cell.comment = _comments[indexPath.row];
        cell.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        return cell;
    }else{
        UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        return cell;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [DetailDescCell heightWithApp:_app];
        }else if (indexPath.row == 1) {
            NSNumber *contentViewHeight = _app.contentHeight;
            return contentViewHeight.floatValue;
        }else if (indexPath.row == 2) {
            return 262;
        }
    }else if (indexPath.section == 1) {
        return 131;
    }else if (indexPath.section == 2) {
        return (SCREEN_WIDTH - 36 - 48) / 7 * 2 + 44;
    }else if (indexPath.section == 3) {
        DSComment *comment = _comments[indexPath.row];
        return comment.cellHeight.floatValue;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        return 44;
    }
    return 0.0000000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    header.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 16, SCREEN_WIDTH - 36, 20)];
    [header addSubview:label];
    if (section == 1) {
        label.text = [NSString stringWithFormat:@"他们眼中的「%@」", self.app.title];
    }else if (section == 2) {
        label.text = @"美过的美友";
    }
    return header;
}

#pragma mark - UIScrolleViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _currentContentInset = _tableView.contentInset;
    _currentContentOffset = _tableView.contentOffset;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 缩放顶部图片
    CGFloat y = scrollView.contentOffset.y;
    _coverImageView.frame = CGRectMake(0, y, SCREEN_WIDTH, -y);
    
    // 判断是否变换三大金刚按键的位置
    if (_collectButton.hidden == YES && y >= 18.5) {
        [self changeButtonToHead];
    }else if (_cell.buttonView.hidden == YES && y < 18.5) {
        [self changeButtonToTableView];
    }
    
    if (y >= scrollView.contentSize.height * 0.5 && _showComment == NO) {
        [self dragBottomView];
    }else if (y < scrollView.contentSize.height * 0.5 && _showComment == YES) {
        [self dragBottomView];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

#pragma mark - 按钮点击事件

- (IBAction)back {
    NSLog(@"点击了返回按钮");
    // [self dismissViewControllerAnimated:NO completion:nil];
//    [UIView animateWithDuration:0.5 animations:^{
//        self.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    } completion:^(BOOL finished) {
//        [self.view removeFromSuperview];
//        [self removeFromParentViewController];
//    }];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)dragBottomView {
    _showComment = !_showComment;
    if (_showComment) {
        [UIView animateWithDuration:0.5 animations:^{
            _bottomView.frame = CGRectMake(-SCREEN_WIDTH + 30, SCREEN_HEIGHT - 44, SCREEN_WIDTH * 2 - 20, 44);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH * 2 - 20, 44);
        }];
    }
}


#pragma mark - 改变案件位置的动画方法
- (void)changeButtonToHead{
    UIButton *b1 = _cell.collectButton;
    UIButton *b2 = _cell.shareButton;
    UIButton *b3 = _cell.downloadButton;
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    CGRect f1 = _collectButton.frame;
    CGRect f2 = _shareButton.frame;
    CGRect f3 = _downloadButton.frame;
    
    _collectButton.frame = [b1 convertRect:b1.bounds toView:window];
    _collectButton.hidden = NO;
    _shareButton.frame = [b2 convertRect:b2.bounds toView:window];
    _shareButton.hidden = NO;
    _downloadButton.frame = [b3 convertRect:b3.bounds toView:window];
    _downloadButton.hidden = b3.hidden;
    
    _cell.buttonView.hidden = YES;
    
    [UIView animateWithDuration:0.1 animations:^{
        _collectButton.frame = f1;
        _shareButton.frame = f2;
        _downloadButton.frame = f3;
    }];
}

- (void)changeButtonToTableView{
    UIButton *b1 = _cell.collectButton;
    UIButton *b2 = _cell.shareButton;
    UIButton *b3 = _cell.downloadButton;
    
    CGRect f1 = b1.frame;
    CGRect f2 = b2.frame;
    CGRect f3 = b3.frame;
    
    b1.frame = [_collectButton convertRect:_collectButton.bounds toView:_cell.buttonView];
    b2.frame = [_shareButton convertRect:_shareButton.bounds toView:_cell.buttonView];
    b3.frame = [_downloadButton convertRect:_downloadButton.bounds toView:_cell.buttonView];
    
    _cell.buttonView.hidden = NO;
    _collectButton.hidden = YES;
    _shareButton.hidden = YES;
    _downloadButton.hidden = YES;
    
    [UIView animateWithDuration:0.1 animations:^{
        b1.frame = f1;
        b2.frame = f2;
        b3.frame = f3;
    }];
    
}

- (void)dealloc{
    if (_footer) {
        [_footer free];
    }
}

@end
