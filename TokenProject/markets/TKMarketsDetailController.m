//
//  TKMarketsDetailController.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsDetailController.h"
#import "QYPPTabBarController.h"
#import "TKMarketsDetailListController.h"
#import "QYPPBarItem.h"

@interface TKMarketsDetailController ()

@end

@implementation TKMarketsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.currencyName;
    [self loadTabBarController];
}

- (void)loadTabBarController
{
    QYPPTabBarController *tabBarController = [[QYPPTabBarController alloc] init];
    tabBarController.viewControllers = [self subViewControllers];
    [self addChildViewController:tabBarController];
    [tabBarController didMoveToParentViewController:self];
    tabBarController.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:tabBarController.view];
    tabBarController.view.backgroundColor = [UIColor whiteColor];
    [tabBarController beginAppearanceTransition:YES animated:NO];
    [tabBarController endAppearanceTransition];
    tabBarController.selectedIndex = 0;
}

- (NSArray *)subViewControllers
{
    TKMarketsDetailListController *markets = [[TKMarketsDetailListController alloc] init];
    markets.qypp_tabBarItem = [[QYPPBarItem alloc] initWithTitle:@"全部价格" image:nil];
    markets.currencyId = self.currencyId;
    markets.tabType = 1;
    
    TKMarketsDetailListController *exchanges = [[TKMarketsDetailListController alloc] init];
    exchanges.qypp_tabBarItem = [[QYPPBarItem alloc] initWithTitle:@"全部交易所" image:nil];
    exchanges.currencyId = self.currencyId;
    exchanges.tabType = 2;
    
    return @[markets,exchanges];
}

@end
