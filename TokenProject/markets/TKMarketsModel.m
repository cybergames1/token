//
//  TKMarketsModel.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/29.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsModel.h"

@implementation TKMarketsModel

@end

@implementation TKMarketsDataModel

@end

@implementation TKMarketsTopNavModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"marketId" : @"id"}];
}

@end

