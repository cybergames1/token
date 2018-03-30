//
//  QYPPBarItem.m
//  paopao_ios
//
//  Created by jianting on 16/5/21.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import "QYPPBarItem.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



CG_INLINE QYPPColor
QYPPColorMake(CGFloat r, CGFloat g, CGFloat b, CGFloat a)
{
    QYPPColor color;
    color.r = r;color.g = g;
    color.b = b;color.a = a;
    return color;
}

@interface QYPPBarItem ()
{
    
    QYPPColor _normalColor;
    QYPPColor _selectedColor;
}

@end

@implementation QYPPBarItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont systemFontOfSize:17];
        _label.textColor = [UIColor blackColor];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_contentView];
        
        [_contentView addSubview:_imageView];
        [_contentView addSubview:_label];
        
        [self setColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [self setColor:UIColorFromRGB(0x0bbe06) forState:UIControlStateSelected];
        
        self.selected = NO;
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image
{
    self = [self init];
    if (self) {
        self.title = title;
        self.image = image;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
        
        _label.text = title;
        [_label sizeToFit];
        [self layoutSubviews];
    }
}

- (void)setImage:(UIImage *)image
{
    if (_image != image) {
        _image = image;
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _imageView.image = image;
        [self layoutSubviews];
    }
}

- (void)layoutSubviews
{
    CGSize imageViewSize = _imageView.image.size;
    _imageView.frame = CGRectMake(0, CGRectGetHeight(self.frame)/2-imageViewSize.height/2, imageViewSize.width, imageViewSize.height);
    
    CGSize labelSize = _label.frame.size;
    _label.frame = CGRectMake(CGRectGetMaxX(_imageView.frame)+3, CGRectGetHeight(self.frame)/2-labelSize.height/2, labelSize.width, labelSize.height);
    
    _contentView.frame = CGRectMake(0, 0, imageViewSize.width+labelSize.width+3, CGRectGetHeight(self.frame));
    _contentView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    
    if (_contentRect.size.width > 0) return;
    
    _contentRect = _contentView.frame;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self tintColorWithPercent:selected ? 1.0 : 0.0];
}

@end


@implementation QYPPBarItem (TintColor)

- (void)setColor:(UIColor *)color forState:(UIControlState)state
{
    float r,g,b,a;
    
    //不用[color getRed:&r green:&g blue:&b alpha:&a];，这个可能会有bug
    CGColorRef colorRef = color.CGColor;
    NSInteger numberComponents = CGColorGetNumberOfComponents(colorRef);
    if (numberComponents < 4) return;
    
    const CGFloat *components = CGColorGetComponents(colorRef);
    r = components[0];
    g = components[1];
    b = components[2];
    a = components[3];
    
    if (state == UIControlStateNormal) {
        _normalColor = QYPPColorMake(r, g, b, a);
    }else if (state == UIControlStateSelected) {
        _selectedColor = QYPPColorMake(r, g, b, a);
    }
    
    [self tintColorWithPercent:self.selected ? 1.0 : 0.0];
}

- (UIColor *)tintColorWithPercent:(CGFloat)percent
{
    CGFloat p = MIN(percent, 1.0);
    p = MAX(0, percent);
    UIColor *color = [UIColor colorWithRed:_normalColor.r+(_selectedColor.r-_normalColor.r)*p
                                     green:_normalColor.g+(_selectedColor.g-_normalColor.g)*p
                                      blue:_normalColor.b+(_selectedColor.b-_normalColor.b)*p
                                     alpha:_normalColor.a+(_selectedColor.a-_normalColor.a)*p];
    _imageView.tintColor = color;
    _label.textColor = color;
    
    return color;
}

- (QYPPColor)currentTintColor
{
    float r,g,b,a;
    
    CGColorRef colorRef = _imageView.tintColor.CGColor;
    NSInteger numberComponents = CGColorGetNumberOfComponents(colorRef);
    if (numberComponents < 4) return QYPPColorMake(0, 0, 0, 0);
    
    const CGFloat *components = CGColorGetComponents(colorRef);
    r = components[0];
    g = components[1];
    b = components[2];
    a = components[3];
    
    return QYPPColorMake(r, g, b, a);
}

@end
