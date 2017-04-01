//
//  TableListViewController.m
//  HXInvestigate
//
//  Created by 董富强 on 16/8/30.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "TableListViewController.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"

#import "HXHomeTableViewCell.h"

@interface TableListViewController ()
<UITableViewDelegate,UITableViewDataSource>
{
    YiRefreshHeader *refreshHeader;
    YiRefreshFooter *refreshFooter;
    
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation TableListViewController

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)listViewDidAppear {
    
    [super listViewDidAppear];
    
    if (!_tableView) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        self.tableView = tableView;
        [self.view addSubview:tableView];
        //
        //        self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        //            [_tableView.mj_header endRefreshing];
        //        }];
        
        
        // YiRefreshHeader  头部刷新按钮的使用
        refreshHeader=[[YiRefreshHeader alloc] init];
        refreshHeader.scrollView=tableView;
        [refreshHeader header];
        typeof(refreshHeader) __weak weakRefreshHeader = refreshHeader;
        refreshHeader.beginRefreshingBlock=^(){
            // 后台执行：
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                sleep(2);
                dispatch_async(dispatch_get_main_queue(), ^{
                    typeof(weakRefreshHeader) __strong strongRefreshHeader = weakRefreshHeader;
                    // 主线程刷新视图
                    [tableView reloadData];
                    [strongRefreshHeader endRefreshing];
                });
            });
        };
        
        // YiRefreshFooter  底部刷新按钮的使用
        refreshFooter=[[YiRefreshFooter alloc] init];
        refreshFooter.scrollView=tableView;
        [refreshFooter footer];
        typeof(refreshFooter) __weak weakRefreshFooter = refreshFooter;
        
        refreshFooter.beginRefreshingBlock=^(){
            // 后台执行：
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                sleep(2);
                dispatch_async(dispatch_get_main_queue(), ^{
                    typeof(weakRefreshFooter) __strong strongRefreshFooter = weakRefreshFooter;
                    // 主线程刷新视图
                    [tableView reloadData];
                    [strongRefreshFooter endRefreshing];
                });
            });
        };
    }

    
    // 是否在进入该界面的时候就开始进入刷新状态
    [refreshHeader beginRefreshing];
    
    [self loadData];
    
}


- (void)loadData {
    
    for (int i = 0; i < 20; i++) {
//        ClassNewsModel 
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    HXHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[HXHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    return cell;
}

- (NSMutableArray *)dataSourceArr {
    
    if (!_dataSourceArr) {
        
        _dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
