//
//  TKRegistSource.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/8.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKRegistSource : NSObject

@property (nonatomic, strong) NSString * mobile;

- (void)requestURL:(NSString *)url success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@property (nonatomic, strong) NSString * smsCode;

- (void)requestloginURL:(NSString *)url success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
