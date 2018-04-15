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

    TKRequest *request = [TKRequest new];
    request.responseDataClassName = @"TKMarketsModel";
    [request GET:url parameters:[TKTools baseParameters]];
    request.success = success;
    request.failure = failure;
}

@end
