//
//  QYPPTabBar.h
//  paopao_ios
//
//  Created by jianting on 16/5/21.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYPPBarItem;
@protocol QYPPTabBarDelegate;

@interface QYPPTabBar : UIView

@property (nonatomic, copy) NSArray <__kindof QYPPBarItem *> * barItems;
@property (nonatomic, weak) id<QYPPTabBarDelegate> delegate;
@property (nonatomic, assign) NSInteger selectedIndex;
@end


@protocol QYPPTabBarDelegate <NSObject>
@optional

- (void)tabBar:(QYPPTabBar *)tabBar didSelectBarItem:(QYPPBarItem *)item;

@end

/**
 * 在 tabBarController 滑动时，tabBar 需要修改相应的 UI 显示
 */
@interface QYPPTabBar (ResetUIWhenTabControllerScroll)

/**
 * 滑动过程中
 * 1,改变 lineView 的位置，长短
 * 2,改变 barItem 上图片和文字的颜色
 * @param xOffset 通过 offset.x 来进行计算
 * @param isWillScroll 区分是手动滑动 scrollView 还是点击 barItem
 */
- (void)resetUIWhenScroll:(CGFloat)xOffset isWillScroll:(BOOL)isWillScroll;

/**
 * 在滑动结束时
 * 需要使超过屏幕的 barItem 显示在屏幕内
 * @param index 通过 index 获取相应的 barItem
 */
- (void)resetContentOffsetWhenSelectAtIndex:(NSInteger)index;

@end
