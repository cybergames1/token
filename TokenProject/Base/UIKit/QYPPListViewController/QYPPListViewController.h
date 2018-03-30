//
//  QYPPListViewController.h
//  paopao_ios
//
//  Created by jianting on 16/5/20.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYPPListViewController : UIViewController <UITableViewDelegate,UICollectionViewDelegate>

#pragma mark - 需要子类覆盖的方法

/** 开始刷新数据 **/
- (void) startRefresh;
/** 开始请求分页数据 **/
- (void) startLoadMore;

/**
 * 在完成刷新操作完成后，有些列表界面需要基于新数据更新界面某些控件的状态，
 * 那么更新状态可以通过子类重载下面的方法实现
 */
- (void) listFinishRefresh;

/**
 * 在下拉加载更多的操作完成后，有些列表界面需要基于新数据更新界面某些控件的状态，
 * 那么更新状态可以通过子类重载下面的方法实现
 */
- (void) listFinishLoadMore;

/**
 * 在请求刷新数据失败后，需要更新一些信息
 */
- (void) listFailureRefresh;

/**
 * 在请求加载更多数据失败后，需要更新一些信息
 */
- (void) listFailureLoadMore;

@end

#pragma mark - TableView

#import "QYPPTableView.h"
#import "QYPPTableViewSource.h"

@interface QYPPListViewController (TableView)

@property (nonatomic, strong) QYPPTableView * tableView;

@property (nonatomic, strong) QYPPTableViewSource * tableViewSource;

/**
 * 注册 tableView 的 cell
 * @param cellClass cell 的类名
 * @param tableViewSourceClassName tableViewSource 继承 QYPPTableViewSource
 * @param identifier cell 重用的 identifier
 */

- (void)registerCell:(NSString *)cellClass
     tableViewSource:(NSString *)tableViewSourceClassName
     reuseIdentifier:(NSString *)identifier;

@end

#pragma mark - CollectionView

#import "QYPPCollectionView.h"
#import "QYPPCollectionViewSource.h"

@interface QYPPListViewController (CollectionView)

@property (nonatomic, strong) QYPPCollectionView * collectionView;

@property (nonatomic, strong) QYPPCollectionViewSource * collectionViewSource;

/**
 * 注册 collectionView 的 cell
 * @param cellClass cell 的类名
 * @param collectionViewSourceClassName collectionViewSource 继承 QYPPCollectionViewSource
 * @param collectionFlowLayoutClassName flowLayout
 * @param identifier cell 重用的 identifier
 */

- (void)registerCell:(NSString *)cellClass
    collectionViewSource:(NSString *)collectionViewSourceClassName
    collectionFlowLayout:(NSString *)collectionFlowLayoutClassName
        reuseIdentifier:(NSString *)identifier;

@end

#pragma mark - cell刷新

@interface QYPPListViewController (CellManager)

/**
 * 删除某一cell
 */
- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  在 indexPath 位置插入一个 item，该 item 对应的数据信息为 itemData。
 */
- (void)insertCellAtIndexPath:(NSIndexPath *)indexPath withData:(id)itemData;

/**
 * 用 itemData 更新特定位置的 cell 内容
 */
- (void)reloadCellAtIndexPath:(NSIndexPath *)indexPath withData:(id)itemData;

/**
 *  重新load Table
 */
- (void)reloadAllCell;

/**
 * 获取 indexPath 对应位置 item 的 data 信息
 */
- (id)itemDataForIndexPath:(NSIndexPath *)indexPath;

/**
 * 获取 indexPath 对应位置的 cell
 */
- (id)cellAtIndexPath:(NSIndexPath *)indexPath;


@end
