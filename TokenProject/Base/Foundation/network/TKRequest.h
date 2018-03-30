//
//  TKRequest.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/29.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义返回请求数据的block类型
typedef void (^ProgressBlock)(NSProgress *progress);
typedef void (^SuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^FailureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface TKRequest : NSObject

@property (nonatomic, copy) ProgressBlock progress;
@property (nonatomic, copy) SuccessBlock success;
@property (nonatomic, copy) FailureBlock failure;

@property (nonatomic, strong) NSString * responseDataClassName;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters;

@end
