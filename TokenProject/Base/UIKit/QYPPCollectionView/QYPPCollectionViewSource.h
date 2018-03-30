//
//  QYPPCollectionViewSource.h
//  paopao_ios
//
//  Created by jianting on 16/5/26.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import "QYPPListViewSource.h"

/**
 * 获取 collectionView 所需要的 dataSource
 * 控制数据的获取情况，数据刷新，加载更多等
 */

@interface QYPPCollectionViewSource : QYPPListViewSource <UICollectionViewDataSource>

/**
 * 给每个 cellItem 赋值，绘制界面
 * 子类实现
 */
- (void)prepareCell:(UICollectionViewCell *) cell forIndexPath:(NSIndexPath *) indexPath;

@end

@interface QYPPCollectionViewSource (FlowLayout)

@property (nonatomic, strong) UICollectionViewFlowLayout * flowLayout;

/**
 * 注册 flowLayout 的类名
 */
- (void)registerflowLayout:(NSString *)flowLayoutClassName;

/**
 * 更新 collectionView 的 flowLayout
 * 需子类实现
 */
- (void)updateFlowLayout;

@end
