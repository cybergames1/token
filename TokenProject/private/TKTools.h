//
//  TKTools.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/13.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKTools : NSObject

+ (instancetype)shareTools;

@property (nonatomic, copy) NSString * api_code;
@property (nonatomic, copy) NSString * api_deviceId;
@property (nonatomic, copy) NSString * api_date;

+ (NSDictionary *)baseParameters;

@end
