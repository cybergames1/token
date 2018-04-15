//
//  TKUser.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/14.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKModel.h"

@interface TKUser : TKModel

@property (nonatomic, strong) NSString<Optional> * token;
@property (nonatomic, strong) NSString<Optional> * udid;
@property (nonatomic, strong) NSString<Optional> * candy;

@end

@interface TKUserManager : TKModel

@property (nonatomic, strong) TKUser * currentUser;

+ (instancetype)sharedManager;

- (BOOL)save;

@end
