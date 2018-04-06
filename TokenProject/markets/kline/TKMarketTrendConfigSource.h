//
//  TKMarketTrendConfigSource.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/6.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKMarketTrendConfigSource : NSObject

@property (nonatomic, strong) NSString * marketId;

- (void)requestConfigURL:(NSString *)url success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
