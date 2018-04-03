//
//  TKMySpaceSource.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/3.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMySpaceSource.h"
#import "TKMySpaceModel.h"

@interface TKMySpaceSource ()

@property (nonatomic, strong) NSMutableArray * listArray;

@end

@implementation TKMySpaceSource

- (id)initWithDelegate:(id<QYPPListViewSourceDelegate>)delegate cellClass:(NSString *)cellClassName cellIdentifier:(NSString *)cellIdentifier cellViewModelType:(NSString *)cellViewModelType
{
    self = [super initWithDelegate:delegate cellClass:cellClassName cellIdentifier:cellIdentifier cellViewModelType:cellViewModelType];
    if (self) {
        _listArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)freshDataSource
{
    TKMySpaceViewModel *vm2 = [TKMySpaceViewModel new];
    vm2.cellHeight = 87;
    
    TKMySpaceViewModel *vm1 = [TKMySpaceViewModel new];
    vm1.cellHeight = 55;
    
    TKMySpaceModel *login = [TKMySpaceModel new];
    login.title = @"登录";
    login.viewModel = vm2;
    
    NSArray *section1 = @[login];
    
    TKMySpaceModel *share = [TKMySpaceModel new];
    share.title = @"推荐 TokenTimer";
    share.viewModel = vm1;
    
    TKMySpaceModel *about = [TKMySpaceModel new];
    about.title = @"关于 TokenTimer";
    about.viewModel = vm1;
    
    TKMySpaceModel *feedback = [TKMySpaceModel new];
    feedback.title = @"意见反馈";
    feedback.viewModel = vm1;
    
    NSArray *section2 = @[share,about,feedback];
    
    TKMySpaceModel *clearcache = [TKMySpaceModel new];
    clearcache.title = @"清除缓存";
    clearcache.viewModel = vm1;
    
    NSArray *section3 = @[clearcache];
    
    [_listArray addObject:section1];
    [_listArray addObject:section2];
    [_listArray addObject:section3];
    
    self.sectionCount = 3;
    
    [self updateData:section1 atSection:0];
    [self updateData:section2 atSection:1];
    [self updateData:section3 atSection:2];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(listViewSourceDidFinish:)]) {
        [self.delegate listViewSourceDidFinish:self];
    }
}

- (void)prepareCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    TKMySpaceModel *item = [self itemDataForIndexPath:indexPath];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.detail;
}

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath
{
    TKMySpaceModel *item = [self itemDataForIndexPath:indexPath];
    return [(TKMySpaceViewModel *)item.viewModel cellHeight];
}

@end
