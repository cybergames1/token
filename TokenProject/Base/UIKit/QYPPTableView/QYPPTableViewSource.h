//
//  QYPPTableViewSource.h
//  paopao_ios
//
//  Created by jianting on 16/5/20.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import "QYPPListViewSource.h"

/**
 * 获取 tableView 所需要的 dataSource
 * 控制数据的获取情况，数据刷新，加载更多等
 */


@interface QYPPTableViewSource : QYPPListViewSource <UITableViewDataSource>

/**
 * 给每个 cellItem 赋值，绘制界面
 * 子类实现
 */
- (void)prepareCell:(UITableViewCell *) cell forIndexPath:(NSIndexPath *)indexPath;

/**
 * 获取给定 indexPath 的 cell 的高度
 * 子类覆盖
 */
- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath;

@end



