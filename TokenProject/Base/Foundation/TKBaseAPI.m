//
//  TKBaseAPI.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/30.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKBaseAPI.h"
#import <CommonCrypto/CommonDigest.h>

@implementation TKBaseAPI

/**
 * 字符串md5加密
 */
+ (NSString *)md5:(NSString *)string
{
    if (string == nil) {
        return nil;
    }
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

/**
 * 数字处理，大于9999，用万作单位，同理大于9999万用亿作单位
 */
+ (NSString *)formatNumber:(CGFloat)number
{
    if (number / 100000000.0 > 1) return [NSString stringWithFormat:@"%.2f亿",number/100000000.0];
    if (number / 10000.0 > 1) return [NSString stringWithFormat:@"%.2f万",number/10000.0];
    if ((number / 100.0 > 1) && (number / 10000.0 < 1)) return [NSString stringWithFormat:@"%.2f",number];
    if (number > 0) return [NSString stringWithFormat:@"%.4f",number];
    return [NSString stringWithFormat:@"%f",number];
}

@end
