//
//  TKNewsModel.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/29.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKNewsModel.h"

@implementation TKNewsModel

@end

@implementation TKNewsSingleModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"newsId" : @"id"}];
}

@end

@implementation TKNewsSingleExtraModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"publishedTime" : @"published_at"}];
}

- (void)setPublishedTimeWithNSString:(NSString *)string
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"YYYY-MM-dd hh:ss";
    self.publishedTime = [formatter dateFromString:string];
}

- (NSString *)JSONObjectForPublishedTime
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"YYYY-MM-dd hh:ss";
    return [formatter stringFromDate:self.publishedTime];
}

@end
