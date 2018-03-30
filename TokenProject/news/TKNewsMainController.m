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

@interface TKNewsMainController ()

@end

@implementation TKNewsMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"资讯";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self registerCell:@"TKNewsCell" tableViewSource:@"TKNewsSource" reuseIdentifier:@"TKNewsCell"];
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
