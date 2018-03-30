//
//  QYPPTableViewSource.m
//  paopao_ios
//
//  Created by jianting on 16/5/20.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import "QYPPTableViewSource.h"


@interface QYPPTableViewSource ()
{
    NSArray * _cellListArray;
}

@end

@implementation QYPPTableViewSource

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

- (void)prepareCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section < 0 || section >= [_cellListArray count]) return;
    
    //设置 cell data 的方法
    // [cell setCellData];
    // [cell setActionDelegate];
    // [cell updateCell];
}

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (cell == nil && self.cellClass) {
        cell = [[self.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self prepareCell:cell forIndexPath:indexPath];
    return cell;
}

@end


