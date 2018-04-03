//
//  NSString+TK.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/30.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TKCategory)

- (NSString *)tk_md5;

/**
 * 给定宽度和字体大小等，得出文字的应该展示的高度
 */
- (NSInteger)lineWithFont:(UIFont *)font constraintWidth:(CGFloat)width;
- (CGFloat)heightWithFont:(UIFont *)font constraintWidth:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font constraintSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)sizeWithFont:(UIFont *)font constraintSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode lineSpacing:(CGFloat)lineSpacing;

@end
