//
//  NSString+TK.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/30.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "NSString+TK.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (TKCategory)

- (NSString *)tk_md5
{
    if (self == nil) {
        return nil;
    }
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

@end
