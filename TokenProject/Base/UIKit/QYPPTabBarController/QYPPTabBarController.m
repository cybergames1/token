//
//  QYPPTabBarController.m
//  paopao_ios
//
//  Created by jianting on 16/5/21.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import "QYPPTabBarController.h"
#import "QYPPTabBar.h"
#import "QYPPBarItem.h"

@interface QYPPScrollView()

@end

@implementation QYPPScrollView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]] && self.contentOffset.x <= 0) {
        return YES;
    }
    return NO;
}

@end

@interface QYPPTabBarController () <UIScrollViewDelegate,QYPPTabBarDelegate,UIToolbarDelegate>
{
    BOOL _isWillScroll;
}

@property (nonatomic, strong) QYPPScrollView * contentView;


@end

@implementation QYPPTabBarController

+ (UIViewController *)controllerValue:(id)value {
    UIViewController *fromController = nil;
    if ([value isKindOfClass:[UIViewController class]]) {
        fromController = (UIViewController *)value;
    }
    else if ([value isKindOfClass:[UIView class]]) {
        fromController = [self viewControllerForView:(UIView *)value];
    }
    else {
        fromController = nil;
    }
    return fromController;
}

+ (UIViewController *)viewControllerForView:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)dealloc
{
    self.contentView.delegate = nil;
    self.tabBar.delegate = nil;
    self.tabBar = nil;
    self.contentView = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _selectedIndex = -1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    [self setSelectedIndex:selectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated
{
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        [self loadViewAtIndex:_selectedIndex];
        [self.tabBar resetContentOffsetWhenSelectAtIndex:_selectedIndex];
        [self.contentView setContentOffset:CGPointMake(_selectedIndex*self.contentView.frame.size.width, self.contentView.contentOffset.y) animated:animated];
        [self.tabBar resetUIWhenScroll:selectedIndex*self.tabBar.frame.size.width isWillScroll:YES];
    }
}

- (UIViewController *)selectedViewController
{
    if (_selectedIndex >= 0 && _selectedIndex < [self.viewControllers count]) {
        return self.viewControllers[_selectedIndex];
    }else {
        return nil;
    }
}

- (void)loadViews
{
    self.tabBar = [[QYPPTabBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    self.tabBar.delegate = self;
    [self.view addSubview:self.tabBar];
    
    self.contentView = [[QYPPScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tabBar.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.tabBar.frame))];
    self.contentView.pagingEnabled = YES;
    self.contentView.showsHorizontalScrollIndicator = NO;
    self.contentView.showsVerticalScrollIndicator = NO;
    self.contentView.delegate = self;
    self.contentView.bounces = NO;
    [self.view insertSubview:self.contentView belowSubview:self.tabBar];
    
    [self loadBarItems];
}

- (void)loadBarItems
{
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:self.viewControllers.count];
    
    for (NSInteger index = 0; index < [self.viewControllers count]; index ++)
    {
        @autoreleasepool {
            UIViewController *vc = self.viewControllers[index];
            
            QYPPBarItem *item = vc.qypp_tabBarItem;
            item = item ? item : [[QYPPBarItem alloc] init];

            [items addObject:item];
        }
    }
    
    self.tabBar.barItems = items;
    [self.tabBar layoutSubviews];
    
    [self updateTabBarHeight];
    
    self.contentView.contentSize = CGSizeMake([items count]*self.contentView.frame.size.width, 10);
//    [self loadViewAtIndex:_selectedIndex];
//    [self.tabBar resetContentOffsetWhenSelectAtIndex:_selectedIndex];
//    [self.contentView setContentOffset:CGPointMake(_selectedIndex*self.contentView.width, self.contentView.contentOffset.y)];
//    [self.tabBar resetUIWhenScroll:0.0 isWillScroll:YES];
}

/** items <= 1时，隐藏 bar **/
- (void)updateTabBarHeight
{
    NSInteger itemsCount = self.viewControllers.count;
    CGRect rect = self.tabBar.frame;
    if (itemsCount <= 1) {
        rect.size.height = 0;
        self.tabBar.hidden = YES;
    }else {
        rect.size.height = 45;
        self.tabBar.hidden = NO;
    }
    self.tabBar.frame = rect;
    self.contentView.frame = CGRectMake(0, CGRectGetMaxY(self.tabBar.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.tabBar.frame));
}

//展示第index个界面
- (void)loadViewAtIndex:(NSInteger)index
{
    if (index < 0 || index >= [self.viewControllers count]) return;
    
    [self removeLastViewController:_selectedIndex];
    _selectedIndex = index;
    [self addCurrentViewController:_selectedIndex];
}

//移除上一个子 controller
//移除的原因是父 controller viewWillAppear 的时候所有子 controller 也会调这个方法
- (void)removeLastViewController:(NSInteger)index
{
    if (index < 0 || index >= [self.viewControllers count]) return;
    
    UIViewController *lastVc = self.viewControllers[index];
    if (lastVc && [lastVc isViewLoaded]) {
        [lastVc removeFromParentViewController];
        [lastVc didMoveToParentViewController:nil];
        [lastVc beginAppearanceTransition:NO animated:NO];
        [lastVc endAppearanceTransition];
    }
}

//添加当前的 controller
- (void)addCurrentViewController:(NSInteger)index
{
    if (index < 0 || index >= [self.viewControllers count]) return;
    
    QYPPBarItem *barItem = self.tabBar.barItems[index];
    barItem.selected = YES;
    
    UIViewController *vc = self.viewControllers[index];
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
    
    vc.view.frame = CGRectMake(index*self.contentView.frame.size.width, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    vc.view.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:vc.view];
    
    if (vc && [vc isViewLoaded]) {
        [vc beginAppearanceTransition:YES animated:NO];
        [vc endAppearanceTransition];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [self.delegate tabBarController:self didSelectViewController:self.viewControllers[index]];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isWillScroll = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat xOffset = scrollView.contentOffset.x;
    [self.tabBar resetUIWhenScroll:xOffset isWillScroll:_isWillScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
    [self loadViewAtIndex:page];
    [self.tabBar resetContentOffsetWhenSelectAtIndex:page];
}

#pragma mark QYPPTabBarDelegate

- (void)tabBar:(QYPPTabBar *)tabBar didSelectBarItem:(QYPPBarItem *)item
{
    _isWillScroll = NO;
    NSInteger index = [self.tabBar.barItems indexOfObject:item];
    [self.contentView scrollRectToVisible:CGRectMake(index*self.contentView.frame.size.width, 0, self.contentView.frame.size.width, self.contentView.frame.size.height) animated:YES];
    [self loadViewAtIndex:index];
}

@end


#import <objc/runtime.h>

@implementation UIViewController (QYPPTabBarControllerItem)

- (QYPPBarItem *)qypp_tabBarItem
{
    return objc_getAssociatedObject(self, @selector(qypp_tabBarItem));
}

- (void)setQypp_tabBarItem:(QYPPBarItem *)qypp_tabBarItem
{
    return objc_setAssociatedObject(self, @selector(qypp_tabBarItem), qypp_tabBarItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (QYPPTabBarController *)qypp_tabBarController
{
    UIViewController *superVC = self.parentViewController;
    
    if (!superVC) {
        superVC = [QYPPTabBarController controllerValue:self.view.superview];
    }
    
    if (superVC && [superVC isKindOfClass:[QYPPTabBarController class]]) {
        return (QYPPTabBarController *)superVC;
    }else {
        return nil;
    }
}

@end
