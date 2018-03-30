//
//  QYPPBarItem.h
//  paopao_ios
//
//  Created by jianting on 16/5/21.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct Color {
    float r;
    float g;
    float b;
    float a;
} QYPPColor;

@interface QYPPBarItem : UIView
{
    UILabel * _label;
    UIImageView * _imageView;
    
    UIView * _contentView;
}

@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) UIImage * image;

@property (nonatomic, assign) CGRect titleRect;
@property (nonatomic, assign) CGRect imageRect;

@property (nonatomic, assign, readonly) CGRect contentRect;

@property (nonatomic) BOOL selected;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image;

@end


@interface QYPPBarItem (TintColor)

/**
 * 设置各种状态下的颜色
 */
- (void)setColor:(UIColor *)color forState:(UIControlState)state;

/**
 * 设置颜色在 normal 和 selected 状态之间的百分比
 */
- (UIColor *)tintColorWithPercent:(CGFloat)percent;

/**
 * 当前的 tintColor
 */
- (QYPPColor)currentTintColor;

@end
