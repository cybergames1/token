//
//  TKMarketsDetailListController.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "QYPPListViewController.h"

@interface TKMarketsDetailListController : QYPPListViewController

//两个tab的类型，1=全部价格，2=全部交易所
@property (nonatomic, assign) NSInteger tabType;
@property (nonatomic, strong) NSString * currencyId;

@end
