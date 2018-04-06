//
//  TKMarketsTimeLineModel.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/6.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsTimeLineModel.h"

@interface TKMarketsTimeLineModel ()

@property (nonatomic, strong) NSMutableDictionary * dict;

@end

@implementation TKMarketsTimeLineModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.dict = [NSMutableDictionary dictionaryWithDictionary:dict];
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dict[@"time"] longLongValue]];
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        NSString *formatTime = [formatter stringFromDate:date];
        [_dict setValue:formatTime forKey:@"time_display"];
    }
    return self;
}

- (NSNumber *)Price
{
    return @([_dict[@"close"] floatValue]);
}

- (CGFloat)Volume
{
    return [_dict[@"voloumefrom"] floatValue] / 100.0f;
}

- (BOOL)isShowTimeDesc
{
    return YES;
}

- (NSString *)DayDatail
{
    return _dict[@"time_display"];
}

- (NSString *)TimeDesc
{
    return _dict[@"time_display"];
}

- (CGFloat)AvgPrice
{
    return 5000;
}

@end
