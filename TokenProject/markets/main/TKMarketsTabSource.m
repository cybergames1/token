//
//  TKMarketsTabSource.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsTabSource.h"
#import "TKRequest.h"

@implementation TKMarketsTabSource

- (void)requestTabURL:(NSString *)url success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    if (!url || [url length] <= 0) return;
    
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
    [request GET:url parameters:parameters];
    request.success = success;
    request.failure = failure;
}

@end
