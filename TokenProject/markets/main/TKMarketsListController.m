//
//  TKMarketsListController.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/31.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsListController.h"
#import "TKMarketsSource.h"
#import "TKMarketsModel.h"
#import "TKMarketsDetailController.h"

#import "TKMarketsTimeLineController.h"

@interface TKMarketsListController ()

@property (nonatomic, strong) NSTimer * refreshPriceTimer;

@end

@implementation TKMarketsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    [self registerCell:@"TKMarketsCell" tableViewSource:@"TKMarketsSource" reuseIdentifier:@"TKMarketsCell"];
    self.tableView.height -= 64+44;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    TKMarketsSource *source = (TKMarketsSource *)self.tableViewSource;
    source.tabId = self.tabId;
    source.marketId = self.marketId;
    source.marketGroupType = self.marketGroupType;
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self p_starTimer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self p_stopTimer];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKMarketsFeedModel *item = [self itemDataForIndexPath:indexPath];
    TKMarketsDetailController *controller = [[TKMarketsDetailController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.currencyId = item.currency_id;
    controller.currencyName = item.currency;
    [self.navigationController pushViewController:controller animated:YES];
    
//    TKMarketsTimeLineController *controller = [[TKMarketsTimeLineController alloc] init];
//    controller.hidesBottomBarWhenPushed = YES;
//    controller.marketId = item.market_id;
//    controller.pairId = item.com_id;
//    [self.navigationController pushViewController:controller animated:YES];
}

- (void)p_starTimer
{
    [self p_stopTimer];
    self.refreshPriceTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(p_refreshPrice) userInfo:nil repeats:YES];
}

- (void)p_stopTimer
{
    if (!self.refreshPriceTimer) return;
    
    [self.refreshPriceTimer invalidate];
    self.refreshPriceTimer = nil;
}

- (void)p_refreshPrice
{
    TKMarketsSource *source = (TKMarketsSource *)self.tableViewSource;
    [source refreshPrice];
}

@end
