//
//  TKCache.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/4.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKCache.h"
#import "SDImageCache.h"

@implementation TKCache

+ (instancetype)sharedCache
{
    static dispatch_once_t onceToken;
    static TKCache* cache = nil;
    dispatch_once(&onceToken, ^{
        cache = [[TKCache alloc] init];
    });
    return cache;
}

- (NSInteger)cacheSize
{
    return [[SDImageCache sharedImageCache] getSize];
}

- (void)clearAllCacheCompletion:(void(^)(void))completion
{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:completion];
}

@end
