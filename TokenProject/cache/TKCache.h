//
//  TKCache.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/4.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKCache : NSObject

+ (instancetype)sharedCache;

- (NSInteger)cacheSize;

- (void)clearAllCacheCompletion:(void(^)(void))completion;

@end
