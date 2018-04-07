//
//  TKMarketsDetailListController.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsDetailListController.h"
#import "TKMarketsDetailMarketListSource.h"
#import "TKMarketsDetailExchangeCell.h"
#import "TKMarketsModel.h"
#import "QYPPAlertView_.h"

@interface TKMarketsDetailListController () <TKMarketsDetailExchangeCellDelegate,QYPPAlertViewDelegate>

@end

@interface QYPPAlertView_ (MarketsDetail)

@property (nonatomic, strong) NSIndexPath * md_indexPath;

@end

@implementation QYPPAlertView_ (MarketsDetail)

- (NSIndexPath *)md_indexPath
{
    return objc_getAssociatedObject(self, @selector(md_indexPath));
}

- (void)setMd_indexPath:(NSIndexPath *)md_indexPath
{
    return objc_setAssociatedObject(self, @selector(md_indexPath), md_indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation TKMarketsDetailListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    CGFloat height = [TKBaseAPI statusBarAndNavgationBarHeight:self.navigationController];
    NSString *cellClassName = (self.tabType == 1) ? @"TKMarketsDetailMarketCell" : @"TKMarketsDetailExchangeCell";
    NSString *sourceClassName = (self.tabType == 1) ? @"TKMarketsDetailMarketListSource" : @"TKMarketsDetailExchangeListSource";
    [self registerCell:cellClassName tableViewSource:sourceClassName reuseIdentifier:cellClassName];
    self.tableView.height -= height+44;
    
    TKMarketsDetailMarketListSource *source = (TKMarketsDetailMarketListSource *)self.tableViewSource;
    source.currencyId = self.currencyId;
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)urlActionAtCell:(TKMarketsDetailExchangeCell *)cell
{
    TKMarketsFeedModel *item = [self itemDataForIndexPath:cell.indexPath];
    QYPPAlertView_ *alertView = [[QYPPAlertView_ alloc] initWithTitle:item.market_name message:item.website delegate:self buttonTitles:@"用 Safari 打开",@"取消",nil];
    alertView.md_indexPath = cell.indexPath;
    [alertView show];
}

- (void)alertView:(QYPPAlertView_ *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TKMarketsFeedModel *item = [self itemDataForIndexPath:alertView.md_indexPath];
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.website] options:@{} completionHandler:nil];
    }
}

@end
