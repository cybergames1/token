//
//  TKNewsSource.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/30.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKNewsSource.h"
#import "TKRequest.h"
#import "TKNewsModel.h"
#import "TKNewsCell.h"
#import "UIImageView+WebCache.h"

@implementation TKNewsSource

- (id)initWithDelegate:(id<QYPPListViewSourceDelegate>)delegate cellClass:(NSString *)cellClassName cellIdentifier:(NSString *)cellIdentifier cellViewModelType:(NSString *)cellViewModelType
{
    self = [super initWithDelegate:delegate cellClass:cellClassName cellIdentifier:cellIdentifier cellViewModelType:cellViewModelType];
    if (self) {
        [self registerNetRequest:@"TKRequest" responseDataModel:@"TKNewsModel"];
    }
    return self;
}

- (void)freshDataSource
{
    NSDictionary *parameters = @{@"catelogue_key" : @"www",
                                 @"limit" : @20,
                                 @"flag" : @"up",
                                 @"information_id" : @"18023"
                                 };
    
    TKRequest *request = self.request;
    [request GET:@"http://api.jinse.com/v3/information/list" parameters:parameters];
}

- (NSArray *)parserData:(id)data
{
    if (!data || ![data isKindOfClass:[TKNewsModel class]]) return [NSArray array];
    
    NSArray *newsList = [(TKNewsModel *)data list];
    [self updateData:newsList atSection:0];
    
    return newsList;
}

- (void)prepareCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    TKNewsSingleModel *itemModel = [self itemDataForIndexPath:indexPath];
    TKNewsCell *newsCell = (TKNewsCell *)cell;
    newsCell.titleLabel.text = itemModel.title;
    newsCell.timeAuthorLabel.text = itemModel.extra.author;
    [newsCell.picImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.extra.thumbnail_pic]];
}

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath
{
    return 101.0;
}

@end
