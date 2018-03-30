//
//  QYPPCollectionViewSource.m
//  paopao_ios
//
//  Created by jianting on 16/5/26.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import "QYPPCollectionViewSource.h"

@interface QYPPCollectionViewSource ()
{
    NSArray * _cellListArray;
}

@end

@implementation QYPPCollectionViewSource

- (instancetype)initWithDelegate:(id<QYPPListViewSourceDelegate>)delegate cellClass:(NSString *)cellClassName cellIdentifier:(NSString *)cellIdentifier cellViewModelType:(NSString *)cellViewModelType
{
    self = [super initWithDelegate:delegate cellClass:cellClassName cellIdentifier:cellIdentifier cellViewModelType:cellViewModelType];
    if (self) {
        _cellListArray = [self viewModelList];
    }
    return self;
}

- (instancetype)initWithDelegate:(id<QYPPListViewSourceDelegate>)delegate cellClass:(NSString *)cellClassName cellIdentifier:(NSString *)cellIdentifier cellViewModelType:(NSString *)cellViewModelType cellViewModelSourceType:(NSString *)cellViewModelSourceType
{
    self = [super initWithDelegate:delegate cellClass:cellClassName cellIdentifier:cellIdentifier cellViewModelType:cellViewModelType cellViewModelSourceType:cellViewModelSourceType];
    if (self) {
        _cellListArray = [self viewModelList];
    }
    return self;
}

#pragma mark Prepare Cell

- (void)prepareCell:(UICollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    NSInteger itemIndex = indexPath.item;
    if (itemIndex < 0 || itemIndex >= [_cellListArray count]) return;
    
    //设置 cell data 的方法
    // [cell setCellData];
    // [cell setActionDelegate];
    // [cell updateCell];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section >= [_cellListArray count]) {
        return 0;
    }
    NSArray *list = [_cellListArray objectAtIndex:section];
    return [list count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionMaxCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.cellClass) return nil;
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    [self prepareCell:cell forIndexPath:indexPath];
    
    return cell;
}

@end

#import <objc/runtime.h>

@implementation QYPPCollectionViewSource (FlowLayout)

- (UICollectionViewFlowLayout *)flowLayout
{
    return objc_getAssociatedObject(self, @selector(flowLayout));
}

- (void)setFlowLayout:(UICollectionViewFlowLayout *)flowLayout
{
    return objc_setAssociatedObject(self, @selector(flowLayout), flowLayout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)registerflowLayout:(NSString *)flowLayoutClassName
{
    if (!flowLayoutClassName || [flowLayoutClassName length] <= 0) return;
    
    self.flowLayout = [[NSClassFromString(flowLayoutClassName) alloc] init];
}

- (void)updateFlowLayout
{
    //需子类实现
}

@end

