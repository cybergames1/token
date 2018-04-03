//
//  QYPPTableView.m
//  paopao_ios
//
//  Created by jianting on 16/5/20.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import "QYPPTableView.h"

@implementation QYPPTableView

- (void)setShowPullRefresh:(BOOL)showPullRefresh
{
    _showPullRefresh = showPullRefresh;
    
    MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)self.mj_header;
    header.hidden = showPullRefresh ? NO : YES;
    
    if (showPullRefresh) {
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    }
}

- (void)setShowPushLoadMore:(BOOL)showPushLoadMore
{
    _showPushLoadMore = showPushLoadMore;
    
    MJRefreshBackNormalFooter *footer = (MJRefreshBackNormalFooter *)self.mj_footer;
    footer.hidden = showPushLoadMore ? NO : YES;
    
    if (showPushLoadMore) {
        [footer setTitle:@"上拉加载" forState:MJRefreshStateIdle];
        [footer setTitle:@"释放加载" forState:MJRefreshStatePulling];
        [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    }
}

@end
