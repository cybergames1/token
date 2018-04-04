//
//  TKMarketsMainController.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/29.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsMainController.h"
#import "QYPPTabBarController.h"
#import "QYPPBarItem.h"
#import "TKRequest.h"
#import "TKMarketsModel.h"
#import "NSString+TK.h"
#import "TKMarketsListController.h"
#import "TKMarketsTabSource.h"

@interface TKMarketsMainController ()

@end

@implementation TKMarketsMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"行情";
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    @weakify(self);
    TKMarketsTabSource *tabSource = [TKMarketsTabSource new];
    [tabSource requestTabURL:@"http://api.lb.mytoken.org/config/topnavigation"
                     success:^(NSURLSessionDataTask *task, id responseObject)
     {
        if (!responseObject || ![responseObject isKindOfClass:[TKMarketsModel class]]) return;
        @strongify(self);
        [self loadTabBarControllerWithData:responseObject];
    }
                     failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"failure:%@",error.description);
    }];
}

//通过服务器返回的tab列表，加载tabBar
- (void)loadTabBarControllerWithData:(id)responseObject
{
    TKMarketsModel *markesModel = (TKMarketsModel *)responseObject;
    QYPPTabBarController *tabBarController = [[QYPPTabBarController alloc] init];
    tabBarController.viewControllers = [self subViewControllersForTabs:markesModel.data.list];
    [self addChildViewController:tabBarController];
    [tabBarController didMoveToParentViewController:self];
    tabBarController.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:tabBarController.view];
    [tabBarController beginAppearanceTransition:YES animated:NO];
    [tabBarController endAppearanceTransition];
    tabBarController.selectedIndex = 1;
}

//生成tabBar的各个tab及相应的viewController
- (NSArray *)subViewControllersForTabs:(NSArray *)tabs
{
    NSInteger count = (tabs.count > 7) ? 7 : tabs.count;
    NSMutableArray *vcList = [NSMutableArray arrayWithCapacity:count];
    
    for (NSInteger i = 0; i < count; i++) {
        @autoreleasepool{
            TKMarketsFeedModel *item = tabs[i];
            TKMarketsListController *vc = [[TKMarketsListController alloc] init];
            vc.qypp_tabBarItem = [[QYPPBarItem alloc] initWithTitle:item.name image:nil];
            vc.tabId = item.unique_ids ?: @"1303";
            vc.marketId = item.c_id;
            vc.marketGroupType = item.group_type;
            [vcList addObject:vc];
        }
    }
    
    return vcList;
}

@end
