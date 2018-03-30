//
//  QYPPListViewSource.m
//  paopao_ios
//
//  Created by jianting on 16/5/27.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import "QYPPListViewSource.h"

@interface QYPPListViewSource ()
{
    NSMutableArray * _cellListArray; //viewModel List
}

@property (nonatomic, strong) NSString * requestUrlString;

@end

@implementation QYPPListViewSource

- (void)dealloc
{
    [_cellListArray removeAllObjects];
    _cellListArray = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initCommonObjects];
    }
    return self;
}

- (instancetype)initWithDelegate:(id<QYPPListViewSourceDelegate>)delegate
                       cellClass:(NSString *)cellClassName
                  cellIdentifier:(NSString *)cellIdentifier
               cellViewModelType:(NSString *)cellViewModelType
{
    self = [self initWithDelegate:delegate
                        cellClass:cellClassName
                   cellIdentifier:cellIdentifier
                cellViewModelType:cellViewModelType
          cellViewModelSourceType:@""];
    return self;
}

- (instancetype)initWithDelegate:(id<QYPPListViewSourceDelegate>)delegate
                       cellClass:(NSString *)cellClassName
                  cellIdentifier:(NSString *)cellIdentifier
               cellViewModelType:(NSString *)cellViewModelType
         cellViewModelSourceType:(NSString *)cellViewModelSourceType
{
    self = [super init];
    if (self) {
        [self initCommonObjects];
        self.delegate = delegate;
        if (cellClassName && [cellClassName length] > 0) {
            self.cellClass = NSClassFromString(cellClassName);
        }
        if (cellIdentifier && [cellIdentifier length] > 0) {
            self.cellIdentifier = cellIdentifier;
        }
        if (cellViewModelType && [cellViewModelType length] > 0) {
            self.cellViewModelType = cellViewModelType;
        }
        if (cellViewModelSourceType && [cellViewModelSourceType length] > 0) {
            self.cellViewModelSourceType = cellViewModelSourceType;
        }
    }
    return self;
}

- (void)initCommonObjects
{
    _cellListArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.sectionCount = 1;
}

- (void)setSectionCount:(NSInteger)sectionCount
{
    _sectionMaxCount = sectionCount;
    [_cellListArray removeAllObjects];
    for (NSInteger index = 0; index < _sectionMaxCount; index++) {
        [_cellListArray addObject:[NSMutableArray array]];
    }
}

- (NSInteger)sectionCount
{
    return _sectionMaxCount;
}

@end

#import <objc/runtime.h>

@implementation QYPPListViewSource (DataManager)

- (BOOL)canLoadMore
{
    return _canLoadMore;
}

- (TKModel *)jsonData
{
    return objc_getAssociatedObject(self, @selector(jsonData));
}

- (void)setJsonData:(TKModel *)jsonData
{
    return objc_setAssociatedObject(self, @selector(jsonData), jsonData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)maxCount
{
    if (self.sectionCount == 1) return [[_cellListArray firstObject] count];
    
    NSInteger count = 0;
    for (NSArray *list in _cellListArray) {
        count += [list count];
    }
    return count;
}

- (void)registerNetRequest:(NSString *)requestClassName responseDataModel:(NSString *)modelClassName
{
    if (!requestClassName || [requestClassName length] <= 0) return;
    
    
    @weakify(self);
    self.request = [[NSClassFromString(requestClassName) alloc] init];
    self.request.responseDataClassName = modelClassName;
    
    self.request.success = ^(NSURLSessionDataTask *task, id responseObject) {
        @strongify(self);
        
//        if (!self.request.isLoadMore) {
//            self.requestUrlString = requestURL.absoluteString;
//        }

        [self handleData:responseObject];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(listViewSourceDidFinish:)]) {
            [self.delegate listViewSourceDidFinish:self];
        }
    };
    
    self.request.failure = ^(NSURLSessionDataTask *task, NSError *error) {
        @strongify(self);
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(listViewSourceDidFailure:)]) {
            [self.delegate listViewSourceDidFailure:self];
        }
    };
}

- (void)registerDataModel:(NSString *)modelClassName
{
    if (!modelClassName || [modelClassName length] <= 0) return;
    self.responseDataModel = [[NSClassFromString(modelClassName) alloc] init];
}

- (void)freshDataSource
{
    //子类实现
}

- (void)loadMoreDataSource
{
    //子类实现
}

#pragma mark Data Manage

- (NSArray *)viewModelList
{
    return _cellListArray;
}

- (void)updateData:(NSArray *)dataList atSection:(NSInteger)section
{
    if (!dataList || section < 0) return;
    
    NSInteger count = [_cellListArray count];
    if (section < count) {
        [_cellListArray replaceObjectAtIndex:section withObject:dataList];
    }else {
        [_cellListArray addObject:dataList];
    }
}

- (void)appendData:(NSArray *)dataList atSection:(NSInteger)section
{
    if (!dataList || section < 0) return;
    
    NSInteger count = [_cellListArray count];
    if (section < count) {
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[_cellListArray[section] copy]];
        [tempArr addObjectsFromArray:dataList];
        [_cellListArray replaceObjectAtIndex:section withObject:tempArr];
    }else {
        [_cellListArray addObject:dataList];
    }
}

- (void)insertData:(NSArray *)dataList atSection:(NSInteger)section
{
    if (!dataList || section < 0) return;
    
    NSInteger count = [_cellListArray count];
    if (section < count) {
        NSMutableArray *tempArr =  [NSMutableArray arrayWithArray:[_cellListArray[section] copy]];
        [tempArr insertObjects:dataList atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [dataList count])]];
        [_cellListArray replaceObjectAtIndex:section withObject:tempArr];
    }else {
        [_cellListArray addObject:dataList];
    }
}

#pragma mark 单个 indexPath 上的数据操作

- (id)itemDataForIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath || indexPath.section < 0 || indexPath.section >= [_cellListArray count]) return nil;
    
    NSArray *list = _cellListArray[indexPath.section];
    if ([list count] <= 0) return nil;
    
    if (indexPath.item < 0 || indexPath.item >= list.count) return nil;
    
    return list[indexPath.item];
}

- (id)itemDataForSection:(NSInteger)section
{
    if (section < 0 || section >= [_cellListArray count]) return nil;
    return _cellListArray[section];
}

- (BOOL)insertItem:(id)dataItem atIndexPath:(NSIndexPath*) indexPath
{
    if (!dataItem || !indexPath || indexPath.section < 0 || indexPath.section >= [_cellListArray count] || indexPath.item < 0) return NO;
    
    NSMutableArray *vmList = [NSMutableArray arrayWithArray:[[_cellListArray objectAtIndex:indexPath.section] copy]];
    [vmList insertObject:dataItem atIndex:indexPath.item];
    [_cellListArray replaceObjectAtIndex:indexPath.section withObject:vmList];
    
    return YES;
}

- (BOOL)deleteItemWithIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath || indexPath.section < 0 || indexPath.section >= [_cellListArray count] || indexPath.item < 0) return NO;
    
    //多个 section
    NSMutableArray *dList = [NSMutableArray arrayWithArray:[_cellListArray[indexPath.section] copy]];
    [dList removeObjectAtIndex:indexPath.item];
    [_cellListArray replaceObjectAtIndex:indexPath.section withObject:dList];
    
    return YES;
}

- (BOOL)updateItem:(id)dataItem atIndexPath:(NSIndexPath *)indexPath
{
    if (!dataItem || !indexPath || indexPath.section < 0 || indexPath.section >= [_cellListArray count] || indexPath.item < 0) return NO;
    
    NSMutableArray *vmList = [NSMutableArray arrayWithArray:[[_cellListArray objectAtIndex:indexPath.section] copy]];
    [vmList replaceObjectAtIndex:indexPath.item withObject:dataItem];
    [_cellListArray replaceObjectAtIndex:indexPath.section withObject:vmList];
    
    return YES;
}

#pragma mark parser data

- (void)handleData:(id)data
{
    _canLoadMore = YES;
    
    if (!data || ![data isKindOfClass:[TKModel class]]) {
        _canLoadMore = NO;
        return;
    }
    self.jsonData = data;
    
    NSArray *modelArr = [self parserData:data];
    if (!modelArr ||  [modelArr count] <= 0) {
        _canLoadMore = NO;
        return;
    }
}

- (NSArray *)parserData:(id)data
{
    return [NSArray array];
}


@end


@implementation TKRequest (NetworkTypeIsRefreshOrLoadMore)

- (BOOL)isLoadMore
{
    return [objc_getAssociatedObject(self, @selector(isLoadMore)) boolValue];
}

- (void)setIsLoadMore:(BOOL)isLoadMore
{
    return objc_setAssociatedObject(self, @selector(isLoadMore), @(isLoadMore), OBJC_ASSOCIATION_ASSIGN);
}

@end
