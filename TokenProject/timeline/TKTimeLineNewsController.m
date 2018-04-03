//
//  TKTimeLineNewsController.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKTimeLineNewsController.h"
#import "TKTimeLineNewsSource.h"
#import "TKTimeLineNewsModel.h"

@interface TKTimeLineNewsController ()

@end

@implementation TKTimeLineNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"快讯";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self registerCell:@"TKTimeLineNewsCell" tableViewSource:@"TKTimeLineNewsSource" reuseIdentifier:@"TKTimeLineNewsCell"];
    [self startRefresh];
}

@end
