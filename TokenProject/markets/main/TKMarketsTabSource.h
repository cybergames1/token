//
//  TKMarketsTabSource.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKMarketsTabSource : NSObject

- (void)requestTabURL:(NSString *)url success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
