 //
//  QYPPListViewController.m
//  paopao_ios
//
//  Created by jianting on 16/5/20.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import "QYPPListViewController.h"
#import <objc/runtime.h>
#import "MJRefresh.h"
#import "MJRefreshComponent.h"

@interface QYPPListViewController () <QYPPListViewSourceDelegate>

@end

@implementation QYPPListViewController

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    
    self.tableViewSource.delegate = nil;
    self.tableViewSource = nil;
    self.tableView = nil;
    
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
    
    self.collectionViewSource.delegate = nil;
    self.collectionViewSource = nil;
    self.collectionView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)startRefresh
{
    if (self.tableViewSource) {
        [self.tableViewSource freshDataSource];
    }
    if (self.collectionViewSource) {
        [self.collectionViewSource freshDataSource];
    }
}

- (void)startLoadMore
{
    if (self.tableViewSource) {
        [self.tableViewSource loadMoreDataSource];
    }
    if (self.collectionViewSource) {
        [self.collectionViewSource loadMoreDataSource];
    }
}

#pragma mark ListViewSourceDelegate

- (void)listViewSourceDidStart:(QYPPListViewSource *)listViewSource
{
    
}

- (void)listViewSourceDidFinish:(QYPPListViewSource *)listViewSource
{
    UIScrollView *scrollView = self.tableView ? self.tableView : self.collectionView;
    
    if (self.tableView) [self.tableView reloadData];
    if (self.collectionView) [self.collectionView reloadData];
    
    //[scrollView.mj_footer setTitle:@"小泡正在全力加载中..." forState:MJRefreshFooterStateRefreshing];
    [scrollView.mj_header endRefreshing];
    
    scrollView.mj_footer.state = listViewSource.canLoadMore ? MJRefreshStateIdle : MJRefreshStateNoMoreData;
    scrollView.hidden = NO;
    
    if (listViewSource.request.isLoadMore) {
        [self listFinishLoadMore];
    }else {
        [self listFinishRefresh];
    }
}

- (void)listViewSourceDidFailure:(QYPPListViewSource *)listViewSource
{
    UIScrollView *scrollView = self.tableView ? self.tableView : self.collectionView;
    //[scrollView.footer setTitle:@"小泡正在全力加载中..." forState:MJRefreshFooterStateRefreshing];
    
    scrollView.hidden = NO;
    
    if (listViewSource.request.isLoadMore) {
        [self listFailureLoadMore];
    }else {
        [self listFailureRefresh];
    }
    
    if (listViewSource.request.isLoadMore) {
        [scrollView.mj_footer endRefreshing];
    }else {
        [scrollView.mj_header endRefreshing];
    }
}


- (void)listFinishRefresh
{
    /*
     * 在刷新完成后做的一些操作，如没有数据等
     * 子类实现
     */
}

- (void)listFinishLoadMore
{
    /**
     * 加载更多完成后做的一些操作
     * 子类实现
     */
}

- (void)listFailureRefresh
{
    
}

- (void)listFailureLoadMore
{
    
}

@end

#pragma mark TableView

@implementation QYPPListViewController (TableView)

- (void)registerCell:(NSString *)cellClass
     tableViewSource:(NSString *)tableViewSourceClassName
     reuseIdentifier:(NSString *)identifier
{
    // init tableViewSource
    if (!self.tableViewSource) {
        QYPPTableViewSource *ts = [[NSClassFromString(tableViewSourceClassName) alloc] initWithDelegate:self
                                                                                              cellClass:cellClass
                                                                                         cellIdentifier:identifier
                                                                                      cellViewModelType:@"Base"];
        self.tableViewSource = ts;
    }
    
    // init tableView
    if (!self.tableView) {
        QYPPTableView *tv = [[QYPPTableView alloc] initWithFrame:self.view.bounds];
        self.tableView = tv;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.bounces = YES;
        self.tableView.hidden = YES;
        [self.view addSubview:self.tableView];
    }
    
    self.tableView.dataSource = self.tableViewSource;
    
    @weakify(self)
        [self.tableView.mj_header setRefreshingBlock:^{
            @strongify(self)
            [self startRefresh];
        }];
    
    [self.tableView.mj_footer setRefreshingBlock:^{
        @strongify(self)
        [self startLoadMore];
    }];
    
    self.tableView.showPullRefresh = YES;
    self.tableView.showPushLoadMore = YES;
}

#pragma mark TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tableViewSource cellHeightAtIndexPath:indexPath];
}

#pragma mark 设置属性

- (QYPPTableView *)tableView
{
    return objc_getAssociatedObject(self, @selector(tableView));
}

- (void)setTableView:(QYPPTableView *)tableView
{
    return objc_setAssociatedObject(self, @selector(tableView), tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (QYPPTableViewSource *)tableViewSource
{
    return objc_getAssociatedObject(self, @selector(tableViewSource));
}

- (void)setTableViewSource:(QYPPTableViewSource *)tableViewSource
{
    return objc_setAssociatedObject(self, @selector(tableViewSource), tableViewSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma mark CollectionView

@implementation QYPPListViewController (CollectionView)

- (void)registerCell:(NSString *)cellClass collectionViewSource:(NSString *)collectionViewSourceClassName collectionFlowLayout:(NSString *)collectionFlowLayoutClassName reuseIdentifier:(NSString *)identifier
{
    if (!self.collectionViewSource) {
        QYPPCollectionViewSource *cs = [[NSClassFromString(collectionViewSourceClassName) alloc] initWithDelegate:self
                                                                                                        cellClass:cellClass
                                                                                                   cellIdentifier:identifier
                                                                                                cellViewModelType:@"Base"];
        self.collectionViewSource = cs;
    }
    
    if (!self.collectionView) {
        QYPPCollectionView *cv = [[QYPPCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewSource.flowLayout];
        self.collectionView = cv;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = self.view.backgroundColor;
        self.collectionView.hidden = YES;
        [self.view addSubview:self.collectionView];
    }
    
    self.collectionView.dataSource = self.collectionViewSource;
    
    if (cellClass) {
        [self.collectionView registerClass:NSClassFromString(cellClass) forCellWithReuseIdentifier:identifier];
    }
    
    @weakify(self)
    [self.collectionView.mj_header setRefreshingBlock:^{
        @strongify(self)
        [self startRefresh];
    }];
    
    [self.collectionView.mj_footer setRefreshingBlock:^{
        @strongify(self)
        [self startLoadMore];
    }];
    
    self.collectionView.showPullRefresh = YES;
    self.collectionView.showPushLoadMore = YES;
}

#pragma mark 设置属性

- (QYPPCollectionView *)collectionView
{
    return objc_getAssociatedObject(self, @selector(collectionView));
}

- (void)setCollectionView:(QYPPCollectionView *)collectionView
{
    return objc_setAssociatedObject(self, @selector(collectionView), collectionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (QYPPCollectionViewSource *)collectionViewSource
{
    return objc_getAssociatedObject(self, @selector(collectionViewSource));
}

- (void)setCollectionViewSource:(QYPPCollectionViewSource *)collectionViewSource
{
    return objc_setAssociatedObject(self, @selector(collectionViewSource), collectionViewSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation QYPPListViewController (CellManager)

- (QYPPListViewSource *)listViewSource
{
    QYPPListViewSource *listViewSource = nil;
    
    if (self.tableViewSource) listViewSource = self.tableViewSource;
    if (self.collectionViewSource) listViewSource = self.collectionViewSource;
    
    return listViewSource;
}

- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath
{
    QYPPListViewSource *listViewSource = [self listViewSource];
    
    BOOL canDelete = [listViewSource deleteItemWithIndexPath:indexPath];
    if (!canDelete)  return;
    
    if ([listViewSource maxCount] > 1) {
        if (self.tableView) {
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }
        
        if (self.collectionView) {
            [UIView performWithoutAnimation:^{
                [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            }];
        }
    }else {
        if (self.tableView) [self.tableView reloadData];
        if (self.collectionView) [self.collectionView reloadData];
    }
}

- (void)insertCellAtIndexPath:(NSIndexPath *)indexPath withData:(id)itemData
{
    QYPPListViewSource *listViewSource = [self listViewSource];
    
    BOOL canInsert = [listViewSource insertItem:itemData atIndexPath:indexPath];
    if (!canInsert)  return;
    
    if ([listViewSource maxCount] > 0) {
        if (self.tableView) {
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }
        
        if (self.collectionView) {
            [UIView performWithoutAnimation:^{
                [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
            }];
        }
    }else{
        if (self.tableView) [self.tableView reloadData];
        if (self.collectionView) [self.collectionView reloadData];
    }
}

- (void)reloadCellAtIndexPath:(NSIndexPath *)indexPath withData:(id)itemData
{
    QYPPListViewSource *listViewSource = [self listViewSource];
    
    BOOL canReload = [listViewSource updateItem:itemData atIndexPath:indexPath];
    if (!canReload) return;
    
    if ([listViewSource maxCount] > 0) {
        if (self.tableView) {
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }

        if (self.collectionView) {
            [UIView performWithoutAnimation:^{
                [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }];
        }
    }else{
        if (self.tableView) [self.tableView reloadData];
        if (self.collectionView) [self.collectionView reloadData];
    }
}

- (void)reloadAllCell
{
    if ( nil != self.tableView )
    {
        [self.tableView reloadData];
    }
    if ( nil != self.collectionView )
    {
        [self.collectionView reloadData];
    }
}

- (id)itemDataForIndexPath:(NSIndexPath *)indexPath
{
    QYPPListViewSource *listViewSource = [self listViewSource];
    
    return [listViewSource itemDataForIndexPath:indexPath];
}

- (id)cellAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView) return [self.tableView cellForRowAtIndexPath:indexPath];
    if (self.collectionView) return [self.collectionView cellForItemAtIndexPath:indexPath];
    return nil;
}


@end
