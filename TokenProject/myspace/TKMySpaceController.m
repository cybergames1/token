//
//  TKMySpaceController.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMySpaceController.h"

@interface TKMySpaceController ()

@end

@implementation TKMySpaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    [self registerCell:@"UITableViewCell" tableViewSource:@"TKMySpaceSource" reuseIdentifier:@"TKMySpaceCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self startRefresh];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 22)];
    view.backgroundColor = self.view.backgroundColor;
    return view;
}

@end
