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

@interface TKRequestManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) NSMutableArray * requestList;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation TKRequestManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static TKRequestManager* manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[TKRequestManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestList = [NSMutableArray arrayWithCapacity:0];
        self.queue = dispatch_queue_create("requestQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

@end

@implementation TKRequest

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
{
    dispatch_async([[TKRequestManager sharedManager] queue], ^{
        [[[TKRequestManager sharedManager] requestList] addObject:self];
    });
    
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
        dispatch_async([[TKRequestManager sharedManager] queue], ^{
            [[[TKRequestManager sharedManager] requestList] removeObject:self];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @try{} @finally{} __typeof__(self) self = __weak_self__;
        if (self.failure) self.failure(task, error);
        dispatch_async([[TKRequestManager sharedManager] queue], ^{
            [[[TKRequestManager sharedManager] requestList] removeObject:self];
        });
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
{
    dispatch_async([[TKRequestManager sharedManager] queue], ^{
        [[[TKRequestManager sharedManager] requestList] addObject:self];
    });
    
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
        dispatch_async([[TKRequestManager sharedManager] queue], ^{
            [[[TKRequestManager sharedManager] requestList] removeObject:self];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @try{} @finally{} __typeof__(self) self = __weak_self__;
        if (self.failure) self.failure(task, error);
        dispatch_async([[TKRequestManager sharedManager] queue], ^{
            [[[TKRequestManager sharedManager] requestList] removeObject:self];
        });
    }];
}

@end
