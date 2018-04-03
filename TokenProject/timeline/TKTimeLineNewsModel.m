//
//  TKTimeLineNewsModel.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKTimeLineNewsModel.h"

@implementation TKTimeLineNewsModel

@end

@implementation TKTimeLineNewsSectionModel

@end

@implementation TKTimeLineNewsLiveModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"liveId" : @"id"}];
}


@end

@implementation TKTimeLineNewsLiveViewModel

@end
