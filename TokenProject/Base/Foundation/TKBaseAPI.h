//
//  TKBaseAPI.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/30.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TKBaseAPI : NSObject

/**
 * 字符串md5加密
 */
+ (NSString *)md5:(NSString *)string;

/**
 * 数字处理，大于9999，用万作单位，同理大于9999万用亿作单位
 */
+ (NSString *)formatNumber:(CGFloat)number;

/**
 * 文件大小转为字符串形式
 */
+ (NSString *)fileSizeWithInteger:(NSInteger)size;

@end
