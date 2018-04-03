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

/**
 * 给定宽度和字体大小等，得出文字的应该展示的高度
 */
- (NSInteger)lineWithFont:(UIFont *)font constraintWidth:(CGFloat)width
{
    CGFloat height = [self heightWithFont:font constraintWidth:width];
    return ceil(height / font.lineHeight);
}

- (CGFloat)heightWithFont:(UIFont *)font constraintWidth:(CGFloat)width
{
    CGSize constrain = CGSizeMake(width, FLT_MAX);
    CGSize size = [self sizeWithFont:font constraintSize:constrain lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
}

- (CGSize)sizeWithFont:(UIFont *)font constraintSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self sizeWithFont:font constraintSize:size lineBreakMode:lineBreakMode lineSpacing:0];
}

- (CGSize)sizeWithFont:(UIFont *)font constraintSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode lineSpacing:(CGFloat)lineSpacing
{
    if (!font) return CGSizeZero;
    
    NSMutableParagraphStyle* paragrap = [[NSMutableParagraphStyle alloc] init];
    paragrap.lineBreakMode = lineBreakMode;
    
    if (lineSpacing > 0) {
        paragrap.lineSpacing = lineSpacing;
    }
    
    NSDictionary* attributes = @{ NSFontAttributeName: font,
                                  NSParagraphStyleAttributeName: paragrap };
    CGRect stringBound = [self boundingRectWithSize:size
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
    return CGSizeMake(ceil(stringBound.size.width), ceil(stringBound.size.height));
}

@end
