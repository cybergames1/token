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
    
    NSDictionary *parameters = @{@"catelogue_key" : @"www",
                                 @"limit" : @20,
                                 @"flag" : @"up",
                                 @"information_id" : @"18023"
                                 };
    TKRequest *request = [TKRequest new];
    [request GET:@"http://api.jinse.com/v3/information/list" parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) return ;
        
        TKNewsModel *newsModel = [[TKNewsModel alloc] initWithDictionary:responseObject error:nil];
        NSLog(@"model:%@",newsModel);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
    }];
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
