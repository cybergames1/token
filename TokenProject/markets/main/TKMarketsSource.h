//
//  TKMarketsSource.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/31.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "QYPPTableViewSource.h"

@interface TKMarketsSource : QYPPTableViewSource

@property (nonatomic, strong) NSString * tabId;
@property (nonatomic, strong) NSString * marketId;
@property (nonatomic, strong) NSString * marketGroupType;

- (void)refreshPrice;

@end
