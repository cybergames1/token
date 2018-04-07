//
//  TKMySpaceAboutController.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/4.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMySpaceAboutController.h"

@interface TKMySpaceAboutController ()

@end

@implementation TKMySpaceAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.title = @"关于我们";
    [self setupView];
}

- (void)setupView
{
    CGFloat top = [TKBaseAPI statusBarAndNavgationBarHeight:self.navigationController];
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 54+top, 76, 76)];
    icon.centerX = self.view.centerX;
    icon.image = [UIImage imageNamed:@"logo_about"];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, icon.bottom+12, self.view.width, 18)];
    title.font = [UIFont boldSystemFontOfSize:18];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"TokenTime";
    
    UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(0, title.bottom+42, self.view.width, 18)];
    info.font = [UIFont systemFontOfSize:18];
    info.textAlignment = NSTextAlignmentCenter;
    info.text = @"合作联系：admin@tokentimer.io";
    
    [self.view addSubview:icon];
    [self.view addSubview:title];
    [self.view addSubview:info];
}

@end
