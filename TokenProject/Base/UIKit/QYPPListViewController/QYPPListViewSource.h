//
//  QYPPListViewSource.h
//  paopao_ios
//
//  Created by jianting on 16/5/27.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKRequest.h"
#import "TKModel.h"

/**
 * 获取 listView 所需要的 dataSource
 * 控制数据的获取情况，数据刷新，加载更多等
 */

@protocol QYPPListViewSourceDelegate;

@interface QYPPListViewSource : NSObject
{
    NSInteger _sectionMaxCount; //总section有多少个
    BOOL _canLoadMore;
}

/**
 * @param delegate 代理回调
 * @param cellClassName 列表 cell 对应的 ClassName
 * @param cellIdentifier cell 唯一性复用标记，不要传 nil
 */

- (instancetype)initWithDelegate:(id<QYPPListViewSourceDelegate>)delegate
                       cellClass:(NSString *)cellClassName
                  cellIdentifier:(NSString *)cellIdentifier
               cellViewModelType:(NSString *)cellViewModelType;


- (instancetype)initWithDelegate:(id<QYPPListViewSourceDelegate>)delegate
                       cellClass:(NSString *)cellClassName
                  cellIdentifier:(NSString *)cellIdentifier
               cellViewModelType:(NSString *)cellViewModelType
         cellViewModelSourceType:(NSString *)cellViewModelSourceType;

/** cell 的 Class **/
@property (nonatomic, weak) Class cellClass;

/** delegate **/
@property (nonatomic, weak) id<QYPPListViewSourceDelegate> delegate;

/** cell 唯一性复用标记 **/
@property (nonatomic, copy) NSString *cellIdentifier;

/** viewModel 的 type **/
@property (nonatomic, copy) NSString *cellViewModelType;

/** viewModel 的 sourceType **/
@property (nonatomic, copy) NSString *cellViewModelSourceType;

/**
 * tableview 的 section 个数，默认1.
 * 如果列表需要多个 section，需要在初始化tableviewSource 后设置该项
 */
@property (nonatomic, assign) NSInteger sectionCount;

/** 数据请求 **/
@property (nonatomic, strong) TKRequest * request;


@end

#pragma mark -- 数据管理

@interface QYPPListViewSource (DataManager)

/** 是否可以加载更多，没有更多数据就能加载更多 **/
@property (nonatomic, readonly) BOOL canLoadMore;

@property (nonatomic, strong) TKModel * jsonData;

/**
 * 注册网络请求 NetRequest 的类名
 * @param requestClassName tableview主网络请求类的 className
 */
- (void)registerNetRequest:(NSString *)requestClassName;

#pragma mark - 以下四个方法需子类实现

/**
 * 刷新数据
 */
- (void)freshDataSource;

/**
 * 加载更多
 */
- (void)loadMoreDataSource;

/**
 * 解析数据，计算界面布局信息
 * 提炼出数据数组
 * 子类实现
 */
- (NSArray *)parserData:(id)data;

#pragma mark - 数据操作，增删改查

/**
 * @return viewModelList，返回展示 cell 的界面 model 的list
 */
- (NSArray *)viewModelList;

/**
 * 刷新后更新数据
 * @param dataList 更新的列表的数据
 * @param section 当前数据所对应的 section
 **/
- (void)updateData:(NSArray *)dataList atSection:(NSInteger)section;

/**
 * 在列表的尾部追加数据
 * @param dataList 更新的列表的数据
 * @param section 当前数据所对应的 section
 **/
- (void)appendData:(NSArray *)dataList atSection:(NSInteger)section;
/**
 * 在列表头部插入数据
 * @param dataList 更新的列表的数据
 * @param section 当前数据所对应的 section
 */
- (void)insertData:(NSArray *)dataList atSection:(NSInteger)section;

#pragma mark - 单个 cell 数据的操作

/**
 * 获取 indexPath 对应位置 cell 的 data 信息
 */
- (id)itemDataForIndexPath:(NSIndexPath *)indexPath;

/**
 * 获取 section 对应位置 cell 的 data 信息
 */
- (id)itemDataForSection:(NSInteger)section;

/**
 * 在 indexPath 位置插入一个 item，该 item 对应的数据信息为 itemData。
 */
- (BOOL)insertItem:(id)dataItem atIndexPath:(NSIndexPath*) indexPath;

/**
 * 删除 indexPath 对应位置上的 data
 * @return YES 如果删除成功，返回NO，如果失败
 */
- (BOOL)deleteItemWithIndexPath:(NSIndexPath*) indexPath;

/**
 * 更新 indexPath 对应位置上的 data
 */
- (BOOL)updateItem:(id)dataItem atIndexPath:(NSIndexPath*) indexPath;

- (NSInteger)maxCount;

@end

#pragma mark -- delegate

@protocol QYPPListViewSourceDelegate <NSObject>
@optional

/** 开始获取数据 **/
- (void)listViewSourceDidStart:(QYPPListViewSource *)listViewSource;

/** 获取数据完成 **/
- (void)listViewSourceDidFinish:(QYPPListViewSource *)listViewSource;

/** 获取数据失败 **/
- (void)listViewSourceDidFailure:(QYPPListViewSource *)listViewSource;


@end


@interface TKRequest (NetworkTypeIsRefreshOrLoadMore)

@property (nonatomic) BOOL isLoadMore;

@end
