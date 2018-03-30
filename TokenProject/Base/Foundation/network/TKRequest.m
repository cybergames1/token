//
//  TKRequest.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/29.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKRequest.h"
#import "AFNetworking.h"
#import "TKModel.h"

@implementation TKRequest

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    @autoreleasepool{} __weak __typeof__(self) __weak_self__ = self;
    return [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        @try{} @finally{} __typeof__(self) self = __weak_self__;
        if (self.progress) self.progress(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @try{} @finally{} __typeof__(self) self = __weak_self__;
        TKModel *data = (self.responseDataClassName && [responseObject isKindOfClass:[NSDictionary class]]) ? [[NSClassFromString(self.responseDataClassName) alloc] initWithDictionary:responseObject error:nil] : responseObject;
        if (self.success) self.success(task, data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @try{} @finally{} __typeof__(self) self = __weak_self__;
        if (self.failure) self.failure(task, error);
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    @autoreleasepool{} __weak __typeof__(self) __weak_self__ = self;
    return [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        @try{} @finally{} __typeof__(self) self = __weak_self__;
        if (self.progress) self.progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @try{} @finally{} __typeof__(self) self = __weak_self__;
        TKModel *data = (!self.responseDataClassName && [responseObject isKindOfClass:[NSDictionary class]]) ? [[NSClassFromString(self.responseDataClassName) alloc] initWithDictionary:responseObject error:nil] : responseObject;
        if (self.success) self.success(task, data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @try{} @finally{} __typeof__(self) self = __weak_self__;
        if (self.failure) self.failure(task, error);
    }];
}

@end
