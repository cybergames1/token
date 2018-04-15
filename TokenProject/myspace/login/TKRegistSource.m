//
//  TKRegistSource.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/8.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKRegistSource.h"
#import "TKRequest.h"
#import "TKUser.h"

@implementation TKRegistSource

- (void)requestURL:(NSString *)url success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    if (!url || [url length] <= 0) return;
    
    NSString *code = [[TKTools shareTools] api_code];
    NSString *deviceUUID = [[TKTools shareTools] api_deviceId];
    NSString *datetimes = [[TKTools shareTools] api_date];
    
    NSDictionary *parameters = @{@"code" : code,
                                 @"datetimes" : datetimes ?: @"",
                                 @"mobile" : self.mobile ?: @"",
                                 @"deviceid" : deviceUUID ?: @"",
                                 };
    TKRequest *request = [TKRequest new];
    [request GET:url parameters:parameters];
    request.success = success;
    request.failure = failure;
}

- (void)requestloginURL:(NSString *)url success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if (!url || [url length] <= 0) return;
    
    NSString *code = [[TKTools shareTools] api_code];
    NSString *datetimes = [[TKTools shareTools] api_date];
    NSString *token = [[TKUserManager sharedManager] currentUser].token;
    
    NSDictionary *parameters = @{@"code" : code,
                                 @"datetimes" : datetimes ?: @"",
                                 @"mobile" : self.mobile ?: @"",
                                 @"sms" : self.smsCode ?: @"",
                                 @"token" : token ?: @"",
                                 };
    TKRequest *request = [TKRequest new];
    [request GET:url parameters:parameters];
    request.success = success;
    request.failure = failure;
}

@end
