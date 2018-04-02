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

@interface TKMarketsListController ()

@end

@implementation TKMarketsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    [self registerCell:@"TKMarketsCell" tableViewSource:@"TKMarketsSource" reuseIdentifier:@"TKMarketsCell"];
    self.tableView.height -= 64+44;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    TKMarketsSource *source = (TKMarketsSource *)self.tableViewSource;
    source.marketId = self.marketId;
    source.marketGroupType = self.marketGroupType;
    [self startRefresh];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKMarketsFeedModel *item = [self itemDataForIndexPath:indexPath];
    TKMarketsDetailController *controller = [[TKMarketsDetailController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.currencyId = item.currency_id;
    controller.currencyName = item.currency;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
