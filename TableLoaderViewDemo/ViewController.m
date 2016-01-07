//
//  ViewController.m
//  TableLoaderViewDemo
//
//  Created by UnAsh on 16/1/7.
//  Copyright © 2016年 ExBye. All rights reserved.
//

#import "ViewController.h"
#import "EXTableLoaderHeaderView.h"
#import "EXTableLoaderFooterView.h"

static NSString * const cellId = @"cellId";

@interface ViewController ()<EXTableLoaderHeaderDelegate,EXTableLoaderFooterDelegate,UITableViewDataSource,UITableViewDelegate>
{
    EXTableLoaderHeaderView * _refreshHeaderView;
    EXTableLoaderFooterView * _refreshFooterView;
    BOOL _reloading;
    NSInteger _rowNum;
}
@property(nonatomic,strong)IBOutlet UITableView * tableView;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _rowNum = 20;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:self.tableView];
    _refreshHeaderView = [[EXTableLoaderHeaderView alloc] init];
    _refreshHeaderView.delegate = self;
    [self.tableView addSubview:_refreshHeaderView];
    [_refreshHeaderView refreshLastUpdatedDate];
    
    _refreshFooterView = [[EXTableLoaderFooterView alloc]init];
    _refreshFooterView.delegate = self;
    [self.tableView addSubview:_refreshFooterView];
    [_refreshFooterView refreshLastUpdatedDate];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _refreshHeaderView.frame = CGRectMake(0, 0, _tableView.bounds.size.width, 0);
    _refreshFooterView.frame = CGRectMake(0, _tableView.contentSize.height, _tableView.bounds.size.width, 0);
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(__unused UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(__unused UITableView *)tableView numberOfRowsInSection:(__unused NSInteger)section
{
    return _rowNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"测试cell: %ld",(long)indexPath.row];
    return cell;
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _reloading = YES;
}

- (void)headerDoneLoadingTableViewData
{
    //  model should call this when its done loading
    _reloading = NO;
    _rowNum = 20;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [self.tableView reloadData];
    [self.view setNeedsLayout];
}

- (void)footerDoneLoadingTableViewData
{
    //  model should call this when its done loading
    _reloading = NO;
    _rowNum += 10;
    [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [self.tableView reloadData];
    [self.view setNeedsLayout];
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(__unused BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark EXTableLoaderHeaderDelegate Methods

- (void)EXTableLoaderHeaderDidTriggerRefresh:(__unused EXTableLoaderHeaderView*)view
{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(headerDoneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)EXTableLoaderHeaderDataSourceIsLoading:(__unused EXTableLoaderHeaderView*)view
{
    return _reloading; // should return if data source model is reloading
}

- (NSDate*)EXTableLoaderHeaderDataSourceLastUpdated:(__unused EXTableLoaderHeaderView*)view
{
    return [NSDate date]; // should return date data source was last changed
}

#pragma mark EXTableLoaderFooterDelegate Methods

- (void)EXTableLoaderFooterDidTriggerRefresh:(__unused EXTableLoaderFooterView *)view
{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(footerDoneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)EXTableLoaderFooterDataSourceIsLoading:(__unused EXTableLoaderFooterView *)view
{
    return _reloading; // should return if data source model is reloading
}

- (NSDate*)EXTableLoaderFooterDataSourceLastUpdated:(__unused EXTableLoaderFooterView *)view
{
    return [NSDate date]; // should return date data source was last changed
}

@end
