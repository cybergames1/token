//
//  TKNewsMainController.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/29.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKNewsMainController.h"
#import "TKRequest.h"
#import "TKNewsModel.h"
#import "TKNewsDetailController.h"

@interface TKNewsMainController ()

@end

@implementation TKNewsMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"资讯";
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    [self registerCell:@"TKNewsCell" tableViewSource:@"TKNewsSource" reuseIdentifier:@"TKNewsCell"];
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TKNewsSingleModel *item = [self itemDataForIndexPath:indexPath];
    TKNewsDetailController *controller = [[TKNewsDetailController alloc] init];
    controller.urlString = item.extra.topic_url;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
