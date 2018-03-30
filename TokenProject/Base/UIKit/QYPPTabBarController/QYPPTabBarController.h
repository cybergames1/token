//
//  QYPPTabBarController.h
//  paopao_ios
//
//  Created by jianting on 16/5/21.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYPPTabBar;
@class QYPPBarItem;
/**
 * 自定义的tabBarController
 * tabBar在上面
 * 用法类似于系统的tabBarController
 */

@interface QYPPScrollView : UIScrollView

@end

@protocol QYPPTabBarControllerDelegate;

@interface QYPPTabBarController : UIViewController

@property (nonatomic, strong) NSArray<__kindof UIViewController *> * viewControllers;

/** 当前的 viewController **/
@property (nonatomic, weak) UIViewController * selectedViewController;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, weak) id<QYPPTabBarControllerDelegate> delegate;

@property (nonatomic, strong) QYPPTabBar * tabBar;

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

@end

/**
 * tabBar上的title或图片，需对应的viewController自身设置
 */

@interface UIViewController (QYPPTabBarControllerItem)

@property (nonatomic, strong) QYPPBarItem * qypp_tabBarItem;

@property (nonatomic, readonly, strong) QYPPTabBarController * qypp_tabBarController;

@end

@protocol QYPPTabBarControllerDelegate <NSObject>
@optional

- (void)tabBarController:(QYPPTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end
