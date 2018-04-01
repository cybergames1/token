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
