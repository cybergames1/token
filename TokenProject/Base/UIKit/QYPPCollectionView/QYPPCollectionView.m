//
//  QYPPCollectionView.m
//  paopao_ios
//
//  Created by jianting on 16/5/26.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import "QYPPCollectionView.h"

@implementation QYPPCollectionView

- (void)setShowPullRefresh:(BOOL)showPullRefresh
{
    _showPullRefresh = showPullRefresh;
    
    self.mj_header.hidden = showPullRefresh ? NO : YES;
    
    if (showPullRefresh) {
//        [self.header setTitle:@"下拉刷新" forState:MJRefreshHeaderStateIdle];
//        [self.header setTitle:@"释放刷新" forState:MJRefreshHeaderStatePulling];
//        [self.header setTitle:@"正在刷新" forState:MJRefreshHeaderStateRefreshing];
    }
}

- (void)setShowPushLoadMore:(BOOL)showPushLoadMore
{
    _showPushLoadMore = showPushLoadMore;
    
    self.mj_footer.hidden = showPushLoadMore ? NO : YES;
    
    if (showPushLoadMore) {
//        [self.footer setTitle:@"上拉显示更多" forState:MJRefreshFooterStateIdle];
//        [self.footer setTitle:@"正在加载" forState:MJRefreshFooterStateRefreshing];
//        [self.footer setTitle:@"没有更多了" forState:MJRefreshFooterStateNoMoreData];
    }
}

@end
