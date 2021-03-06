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

@interface TKNewsSource ()

@property (nonatomic, strong) NSString * bottomId;

@end

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
    NSString *topId = [[NSUserDefaults standardUserDefaults] objectForKey:@"News_top_id"];
    
    NSDictionary *parameters = @{@"flag" : @"up",
                                 @"information_id" : topId ?: @"0",
                                 };
    NSMutableDictionary *allparameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [allparameters addEntriesFromDictionary:[TKTools baseParameters]];
    
    TKRequest *request = self.request;
    request.isLoadMore = NO;
    [request GET:@"http://118.89.151.44/API/information.php" parameters:allparameters];
}

- (void)loadMoreDataSource
{
    NSDictionary *parameters = @{@"flag" : @"down",
                                 @"information_id" : self.bottomId ?: @"0",
                                 };
    NSMutableDictionary *allparameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [allparameters addEntriesFromDictionary:[TKTools baseParameters]];
    
    TKRequest *request = self.request;
    request.isLoadMore = YES;
    [request GET:@"http://118.89.151.44/API/information.php" parameters:allparameters];
}

- (NSArray *)parserData:(id)data
{
    if (!data || ![data isKindOfClass:[TKNewsModel class]]) return [NSArray array];
    
    TKNewsModel *model = (TKNewsModel *)data;
    self.bottomId = model.bottom_id;
    [[NSUserDefaults standardUserDefaults] setObject:model.top_id ?: @"0" forKey:@"News_top_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSArray *newsList = [model list];
    if (!self.request.isLoadMore) {
        [self updateData:newsList atSection:0];
    }else {
        [self appendData:newsList atSection:0];
    }
    
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
