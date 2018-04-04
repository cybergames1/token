//
//  TKMySpaceController.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMySpaceController.h"
#import "TKLoginController.h"
#import "TKMySpaceShareController.h"
#import "TKMySpaceAboutController.h"

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        //登录
        TKLoginController *controller = [TKLoginController new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:nil];
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        //推荐APP
    }else if (indexPath.section == 1&& indexPath.row == 1) {
        //关于
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        //清除缓存
    }else {
        //其他
    }
}

@end
