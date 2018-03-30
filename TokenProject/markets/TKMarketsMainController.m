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

@interface TKMarketsMainController ()

@end

@implementation TKMarketsMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"行情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *model = device.model;
    NSString *systemVersion = [NSString stringWithFormat:@"%@ %@", device.systemName, device.systemVersion];
    NSString *deviceUUID = [[device identifierForVendor] UUIDString];
    
    NSString *code = [TKBaseAPI md5:[NSString stringWithFormat:@"thalesky_eos_%lld",Current_TimeInterval]];
    NSDictionary *parameters = @{@"change_type" : @"change_utc0",
                                 @"code" : code,
                                 @"device_model" : model,
                                 @"device_os" : systemVersion,
                                 @"language" : @"zh_CN",
                                 @"legal_currency" : @"CNY",
                                 @"mytoken" : @"d10a54b9c85586a5af9a6218e580ec99",
                                 @"platform" : @"ios",
                                 @"timestamp" : @(Current_TimeInterval),
                                 @"type" : @2,
                                 @"udid" : deviceUUID,
                                 @"v" : @"1.6.5",
                                 };
    TKRequest *request = [TKRequest new];
    request.responseDataClassName = @"TKMarketsModel";
    [request GET:@"http://api.lb.mytoken.org/config/topnavigation" parameters:parameters];
    @weakify(self);
    request.success = ^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"response:%@",responseObject);
        if (!responseObject || ![responseObject isKindOfClass:[TKMarketsModel class]]) return;
        
        @strongify(self);
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
    };
    request.failure = ^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure:%@",error.description);
    };
}

- (NSArray *)subViewControllersForTabs:(NSArray *)tabs
{
    NSInteger count = (tabs.count > 7) ? 7 : tabs.count;
    NSMutableArray *vcList = [NSMutableArray arrayWithCapacity:count];
    
    for (NSInteger i = 0; i < count; i++) {
        @autoreleasepool{
            TKMarketsTopNavModel *item = tabs[i];
            TKMarketsListController *vc = [[TKMarketsListController alloc] init];
            vc.qypp_tabBarItem = [[QYPPBarItem alloc] initWithTitle:item.name image:nil];
            [vcList addObject:vc];
        }
    }
    
    return vcList;
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
