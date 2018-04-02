//
//  QYPPAlertView_.h
//  QYPPUIKit
//
//  Created by jianting on 2017/6/5.
//  Copyright © 2017年 com.qiyi.ppq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, QYPPAlertStyle) {
    QYPPAlertStyleNormal = 0, //普通样式
    QYPPAlertStyleCustom1 = 1, //定制样式1-上面有心情图片
};

//定制样式1-上面图片的风格
typedef NS_ENUM(NSInteger, QYPPAlertCustom1Sytle) {
    QYPPAlertCustom1SytleGeneral = 1, //普通心情
    QYPPAlertCustom1SytlePositive = 2, //高兴心情
    QYPPAlertCustom1SytleNegative = 3, //悲伤心情
};

@interface QYPPAlertView_ : UIView

@property (nonatomic, strong) UIView * customView;
/* 
 * 需要引导的提示按钮的 index,用于该按钮提示词加粗
 * 顺序是从左到右，从上到下
 */
@property (nonatomic, assign) NSInteger activityIndex;

/**
 * 弹窗的风格样式
 */
@property (nonatomic ,assign) QYPPAlertStyle style;

/**
 * 弹窗为心情风格的时候三种心情风格
 */
@property (nonatomic ,assign) QYPPAlertCustom1Sytle custom1Style;

/**
 * 盖在弹框上面的图片，特殊样式
 */
@property (nonatomic, strong) UIImage * topImage;

/**
 * 右上角是否需要关闭按钮
 */
@property (nonatomic) BOOL needCloseButton;

/**
 * otherButtonTitles最后一定要加 nil
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /**<QYPPAlertViewDelegate>*/)delegate buttonTitles:(NSString *)otherButtonTitles, ...;

- (void)show;

- (void)dismiss;
- (void)dismissWithClickButtonIndex:(NSInteger)index;

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

@end

@protocol QYPPAlertViewDelegate <NSObject>

- (void)alertView:(QYPPAlertView_ *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
