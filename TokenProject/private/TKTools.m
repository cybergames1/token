//
//  TKTools.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/13.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKTools.h"
#import "TKUser.h"

@implementation TKTools

+ (instancetype)shareTools
{
    static dispatch_once_t onceToken;
    static TKTools* manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[TKTools alloc] init];
    });
    return manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.api_deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return self;
}

- (NSString *)api_date
{
    return [NSString stringWithFormat:@"%@",@(Current_TimeInterval)];
}

- (NSString *)api_code
{
    NSLog(@"code:%@",[NSString stringWithFormat:@"%lldazfeb_1989",Current_TimeInterval]);
    return [TKBaseAPI md5:[NSString stringWithFormat:@"%lldazfeb_1989",Current_TimeInterval]];
}

+ (NSDictionary *)baseParameters
{
    NSString *code = [[TKTools shareTools] api_code];
    NSString *datetimes = [[TKTools shareTools] api_date];
    NSString *token = [[[TKUserManager sharedManager] currentUser] token];
    NSString *udid = [[[TKUserManager sharedManager] currentUser] udid];
    
    NSDictionary *parameter = @{@"code" : code ?: @"",
                                @"datetimes" : datetimes ?: @"",
                                @"token" : token ?: @"",
                                @"udid" : udid ?: @"",
                                };
    return parameter;
}

@end
