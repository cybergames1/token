//
//  QYPPAlertView_.m
//  QYPPUIKit
//
//  Created by jianting on 2017/6/5.
//  Copyright © 2017年 com.qiyi.ppq. All rights reserved.
//

#import "QYPPAlertView_.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define Basic_Button_Tag 2323

@interface QYPPAlertView_ ()
{
    UIView * _background;
    UIView * _contentView;
    
    id<QYPPAlertViewDelegate> _delegate;
    NSMutableArray * _buttonTitles;
    
    UILabel * _titleLabel;
    UILabel * _messageLabel;
    UIView * _buttonsTab;
}

@end

@implementation QYPPAlertView_

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate buttonTitles:(NSString *)otherButtonTitles, ...
{
    self = [self initWithFrame:CGRectMake(0, 0, 270, 0)];
    if (self) {
        _delegate = delegate;
        
        if (title) {
            _titleLabel.text = title;
            [_titleLabel sizeToFit];
            _titleLabel.frame = CGRectMake(0, 22, CGRectGetWidth(self.frame), CGRectGetHeight(_titleLabel.frame));
            _titleLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        if (message) {
            NSInteger fontSize = ([message length] > 15 || title) ? 15 : 18;
            _messageLabel.font = [UIFont systemFontOfSize:fontSize];
            _messageLabel.minimumScaleFactor = 5.0/6.0;
            _messageLabel.adjustsFontSizeToFitWidth = YES;
            _messageLabel.numberOfLines = [message length] > 15 ? 0 : 1;
            
            if ([message length] > 15) {
                NSMutableAttributedString *attributedMessage;
                if ([message isKindOfClass:[NSAttributedString class]]) {
                    attributedMessage =[[NSMutableAttributedString alloc] initWithAttributedString:(NSAttributedString*)message];
                }else{
                    attributedMessage = [[NSMutableAttributedString alloc] initWithString:message];
                }
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                [paragraphStyle setLineSpacing:10];
                [attributedMessage addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [message length])];
                _messageLabel.attributedText = attributedMessage;
            }else {
                _messageLabel.text = message;
            }
            
            CGFloat top = title ? CGRectGetMaxY(_titleLabel.frame)+14 : [message length] > 15 ? 22 : 29;
            _messageLabel.frame = CGRectMake(20, top, CGRectGetWidth(self.frame)-40, [message length] > 15 ? 25*([message length]/15+1) : fontSize);
            _messageLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        CGFloat customHeight = CGRectGetMaxY(_messageLabel.frame)+(([message length] > 15 || title) ? 22: 29);
        _customView.frame = CGRectMake(0, 0, self.frame.size.width, customHeight);
        
        _buttonTitles = [NSMutableArray arrayWithCapacity:0];
        
        if (otherButtonTitles) {
            [_buttonTitles addObject:otherButtonTitles];
            
            va_list argList;
            va_start(argList, otherButtonTitles);
            id arg;
            while ((arg = va_arg(argList, id))) {
                [_buttonTitles addObject:arg];
            }
            va_end(argList);
        }
        
        [self p_loadButtons];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        _customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0)];
        [self addSubview:_customView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, 0, 0)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        [_customView addSubview:_titleLabel];
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.textColor = UIColorFromRGB(0x333333);
        _messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [_customView addSubview:_messageLabel];
        
        _buttonsTab = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_buttonsTab];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [window addSubview:_background];
    [window addSubview:_contentView];
}

- (void)show
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    
    UIView *p_background = [[UIView alloc] initWithFrame:window.bounds];
    p_background.backgroundColor = [UIColor blackColor];
    p_background.alpha = 0.0;
    _background = p_background;
    
    UIView *p_content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 0)];
    p_content.backgroundColor = [UIColor clearColor];
    p_content.alpha = 0.0;
    _contentView = p_content;
    
    UIImageView *p_top = nil;
    if (_topImage) {
        p_top = [[UIImageView alloc] initWithImage:_topImage];
        p_top.frame = CGRectMake(0, 0, _topImage.size.width, _topImage.size.height);
    }
    
    UIButton *p_close = nil;
    if (_needCloseButton) {
        p_close = [UIButton buttonWithType:UIButtonTypeCustom];
        [p_close setImage:[UIImage imageNamed:@"qypp_alert_close"] forState:UIControlStateNormal];
        p_close.frame = p_top ? CGRectMake(CGRectGetMaxX(p_top.frame)-25, CGRectGetMaxY(p_top.frame)-40, 50, 50) :
                                CGRectMake(CGRectGetMaxX(self.frame)+25, CGRectGetMinY(self.frame)-25, 50, 50);
        [p_close addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.frame = CGRectMake(0, p_top ? CGRectGetMaxY(p_top.frame)-10 : p_close ? 25 : 0, 270, CGRectGetHeight(self.frame));
    p_content.frame = CGRectMake(0, 0, p_close ? 295 : 270, CGRectGetHeight(p_top.frame)+CGRectGetHeight(self.frame));
    p_content.center = CGPointMake(CGRectGetWidth(window.frame)/2, CGRectGetHeight(window.frame)/2);
    p_content.transform = CGAffineTransformMakeScale(1.2, 1.2);
    
    [p_content addSubview:self];
    [p_content addSubview:p_top];
    [p_content addSubview:p_close];
    
    [window addSubview:p_background];
    [window addSubview:p_content];
    
    [UIView animateWithDuration:0.25 animations:^{
        p_background.alpha = 0.5;
        
        p_content.transform = CGAffineTransformIdentity;
        p_content.alpha = 1.0;
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        _background.alpha = 0.0;
        
        _contentView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        _contentView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_background removeFromSuperview];
        [_contentView removeFromSuperview];
        _background = nil;
        _contentView = nil;
    }];
}

- (void)dismissWithClickButtonIndex:(NSInteger)index
{
    [self buttonClicked:[_buttonsTab viewWithTag:index+Basic_Button_Tag]];
}

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex < 0 || buttonIndex >= [_buttonTitles count]) return nil;
    
    return _buttonTitles[buttonIndex];
}

#pragma mark - CustomView区

- (void)setCustomView:(UIView *)customView
{
    if (_customView != customView) {
        [_customView removeFromSuperview];
        _customView = customView;
        [self addSubview:_customView];
        
        _buttonsTab.frame = CGRectMake(0, CGRectGetMaxY(_customView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(_buttonsTab.frame));
        
        CGRect rect = self.frame;
        rect.size.height = CGRectGetMaxY(_buttonsTab.frame);
        self.frame = rect;
    }
}

- (void)setStyle:(QYPPAlertStyle)style
{
    switch (style) {
        case QYPPAlertStyleNormal:
            _titleLabel.textColor = UIColorFromRGB(0x333333);
            break;
        case QYPPAlertStyleCustom1:
            _titleLabel.textColor = UIColorFromRGB(0x666666);
            break;
        default:
            break;
    }
}

- (void)setCustom1Style:(QYPPAlertCustom1Sytle)custom1Style
{
    switch (custom1Style) {
        case QYPPAlertCustom1SytleGeneral:
            self.topImage = [UIImage imageNamed:@"qypp_alert_general"];
            break;
        case QYPPAlertCustom1SytlePositive:
            self.topImage = [UIImage imageNamed:@"qypp_alert_positive"];
            break;
        case QYPPAlertCustom1SytleNegative:
            self.topImage = [UIImage imageNamed:@"qypp_alert_negative"];
            break;
        default:
            break;
    }
}

#pragma mark - 加载下面的按钮区

- (void)setActivityIndex:(NSInteger)activityIndex
{
    _activityIndex = activityIndex;
    
    UIButton *btn = [_buttonsTab viewWithTag:Basic_Button_Tag+activityIndex];
    if (!btn || ![btn isKindOfClass:[UIButton class]]) return;
    
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
}

- (void)p_loadButtons
{
    if ([_buttonTitles count] == 2) {
        [self p_loadHorizontalButtons];
    }else {
        [self p_loadVerticalButtons];
    }
    
    CGRect rect = self.frame;
    rect.size.height = CGRectGetMaxY(_buttonsTab.frame);
    self.frame = rect;
}

- (void)p_loadVerticalButtons
{
    for (int i = 0; i < [_buttonTitles count]; i++) {
        @autoreleasepool {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTag:Basic_Button_Tag+i];
            [btn setFrame:CGRectMake(0, 45*i, CGRectGetWidth(self.frame), 45)];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
            [btn setTitleColor:UIColorFromRGB(0x0bbe06) forState:UIControlStateNormal];
            [btn setTitle:_buttonTitles[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonsTab addSubview:btn];
            
            CGFloat lineHeight = 1./([UIScreen mainScreen].scale);
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45*i, CGRectGetWidth(self.frame), lineHeight)];
            line.backgroundColor = UIColorFromRGB(0xe6e6e6);
            [_buttonsTab addSubview:line];
        }
    }
    
    _buttonsTab.frame = CGRectMake(0, CGRectGetMaxY(_customView.frame), CGRectGetWidth(self.frame), [_buttonTitles count]*45);
}

- (void)p_loadHorizontalButtons
{
    for (int i = 0; i < [_buttonTitles count]; i++) {
        @autoreleasepool {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTag:Basic_Button_Tag+i];
            [btn setFrame:CGRectMake((CGRectGetWidth(self.frame)/2)*i, 0, CGRectGetWidth(self.frame)/2, 45)];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
            [btn setTitle:_buttonTitles[i] forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromRGB(0x0bbe06) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonsTab addSubview:btn];
        }
    }
    
    CGFloat lineHeight = 1./([UIScreen mainScreen].scale);
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), lineHeight)];
    line.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [_buttonsTab addSubview:line];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2, CGRectGetMaxY(line.frame), lineHeight, 45)];
    line2.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [_buttonsTab addSubview:line2];
    
    _buttonsTab.frame = CGRectMake(0, CGRectGetMaxY(_customView.frame), CGRectGetWidth(self.frame), 45);
}

- (void)buttonClicked:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [_delegate alertView:self clickedButtonAtIndex:sender.tag-Basic_Button_Tag];
    }
    
    [self dismiss];
}

@end
