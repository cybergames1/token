//
//  QYPPTabBar.m
//  paopao_ios
//
//  Created by jianting on 16/5/21.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import "QYPPTabBar.h"
#import "QYPPBarItem.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface QYPPTabBar () <UIScrollViewDelegate>
{
}

@property (nonatomic, strong) UIScrollView * contentView;
@property (nonatomic, strong) UIView * lineView;

@end

@implementation QYPPTabBar


- (void)dealloc
{
    self.contentView.delegate = nil;
    self.contentView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //磨玻璃view
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
        [self addSubview:toolbar];
        
        CGFloat one_pixel = 1.0 / [UIScreen mainScreen].scale;
        
        self.contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.contentView.showsVerticalScrollIndicator = NO;
        self.contentView.showsHorizontalScrollIndicator = NO;
        self.contentView.delegate = self;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentView];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-3-2-one_pixel, 12, 3)];
        //self.lineView.layer.masksToBounds = YES;
        self.lineView.layer.cornerRadius = 1.5;
        self.lineView.clipsToBounds = YES;
        self.lineView.backgroundColor = UIColorFromRGB(0x0bbe06);
        
        UIView *sepeLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-one_pixel, self.frame.size.width, one_pixel)];
        sepeLine.backgroundColor = UIColorFromRGB(0xe6e6e6);
        [self addSubview:sepeLine];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *v in self.contentView.subviews) {
        [v removeFromSuperview];
    }
    
    CGFloat edge = [self itemEdge];
    CGFloat allWidth = 0.0;
    for (NSInteger index = 0; index < self.barItems.count; index ++) {
        QYPPBarItem *item = self.barItems[index];
        CGFloat width = item.contentRect.size.width-3+edge;
        item.frame = CGRectMake(allWidth, 0, width, self.frame.size.height);
        [self.contentView addSubview:item];
        allWidth += width;
    }
    
    [self.contentView addSubview:self.lineView];
    self.contentView.contentSize = CGSizeMake(MAX(self.frame.size.width, allWidth), self.contentView.frame.size.height);
}

- (CGFloat)itemEdge
{
    CGFloat allWidth = 0.0;
    for (QYPPBarItem *item in self.barItems) {
        allWidth+= item.contentRect.size.width-3;
    }
    CGFloat edge = MAX((self.frame.size.width-allWidth)/(self.barItems.count*1.0),30);
    return edge;
}

- (void)tapAction:(UIGestureRecognizer *)recogninzer
{
    if ([self.barItems count] <= 0) return;
    
    CGPoint position = [recogninzer locationInView:self];
    QYPPBarItem *selectedItem = [self barItemAtPoint:position];
    
    if(!selectedItem) {
        return;
    }
    
    [self resetContentOffsetWhenSelectAtIndex:[self.barItems indexOfObject:selectedItem]];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectBarItem:)]) {
        [self.delegate tabBar:self didSelectBarItem:selectedItem];
    }
}

- (QYPPBarItem *)barItemAtPoint:(CGPoint)point
{
    QYPPBarItem *barItem = nil;
    
    for (QYPPBarItem *item in self.barItems) {
        item.selected = NO;
        if (CGRectContainsPoint([self mirrorFrame:item.frame], point)) {
            barItem = item;
        }
    }
    
    barItem.selected = YES;
    
    return barItem;
}

- (CGRect)mirrorFrame:(CGRect)frame
{
    frame.origin.x -= self.contentView.contentOffset.x;
    return frame;
}
@end


#import <objc/runtime.h>

@implementation QYPPTabBar (ResetUIWhenTabControllerScroll)

- (void)resetUIWhenScroll:(CGFloat)xOffset isWillScroll:(BOOL)isWillScroll
{
    CGFloat pageOffset = xOffset/self.frame.size.width;
    NSInteger currentPage = pageOffset;
    
    NSInteger firstIndex = currentPage;
    NSInteger secondIndex = currentPage+1;
    
    CGFloat percent = pageOffset - firstIndex;
    NSInteger itemsCount = [self.barItems count];
    
    secondIndex = (itemsCount > 0) ? secondIndex%itemsCount : secondIndex;
    
    if (firstIndex >= itemsCount) return;
    
    //如果是点击 barItem，则不用设置 tintColorPercent 的方式改变颜色
    if (isWillScroll) {
        QYPPBarItem * firstItem = self.barItems[firstIndex];
        QYPPBarItem * secondImte = self.barItems[secondIndex];
        
        [firstItem tintColorWithPercent:1-percent];
        [secondImte tintColorWithPercent:percent];
        
        CGFloat moveWidth = secondImte.center.x-firstItem.center.x;
        CGRect rect = self.lineView.frame;
        rect.size.width = (percent <= 0.5) ? 12+(2*percent)*moveWidth : 12+(2*(1-percent))*moveWidth;
        self.lineView.frame = rect;
        self.lineView.center = CGPointMake(firstItem.center.x+percent*moveWidth, self.lineView.center.y);
    }else {
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.center = CGPointMake([self currentBarItem].center.x, self.lineView.center.y);
        }];
    }
}

- (void)resetContentOffsetWhenSelectAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.barItems.count) return;
    
    QYPPBarItem *barItem = self.barItems[index];
    [self setCurrentBarItem:barItem];
    
    CGFloat xOffset = barItem.center.x-self.frame.size.width/2;
    xOffset = MAX(0, xOffset);
    xOffset = MIN(self.contentView.contentSize.width-self.frame.size.width, xOffset);
    
    [self selectBarItemAtIndex:index];
    [self.contentView setContentOffset:CGPointMake(xOffset, self.contentView.contentOffset.y) animated:YES];
}

- (void)selectBarItemAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.barItems.count) return;
    
    for (QYPPBarItem *barItem in self.barItems) {
        barItem.selected = NO;
    }

    QYPPBarItem *barItem = self.barItems[index];
    barItem.selected = YES;
}

/**
 * 当需要显示当前选择的 barItem 到屏幕内时需要滑动 scrollView
 * 这是需要调整 lineView 的位置
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.lineView.center = CGPointMake([self currentBarItem].center.x, self.lineView.center.y);
}

- (QYPPBarItem *)currentBarItem
{
    return objc_getAssociatedObject(self, @selector(currentBarItem));
}

- (void)setCurrentBarItem:(QYPPBarItem *)currentBarItem
{
    return objc_setAssociatedObject(self, @selector(currentBarItem), currentBarItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
