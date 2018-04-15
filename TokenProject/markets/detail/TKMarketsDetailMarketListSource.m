//
//  TKMarketsDetailMarketListSource.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsDetailMarketListSource.h"
#import "TKMarketsModel.h"
#import "TKMarketsDetailMarketCell.h"

@interface TKMarketsDetailMarketListSource ()

@property (nonatomic, assign) NSInteger page;

@end

@implementation TKMarketsDetailMarketListSource

- (id)initWithDelegate:(id<QYPPListViewSourceDelegate>)delegate cellClass:(NSString *)cellClassName cellIdentifier:(NSString *)cellIdentifier cellViewModelType:(NSString *)cellViewModelType
{
    self = [super initWithDelegate:delegate cellClass:cellClassName cellIdentifier:cellIdentifier cellViewModelType:cellViewModelType];
    if (self) {
        [self registerNetRequest:@"TKRequest" responseDataModel:@"TKMarketsModel"];
    }
    return self;
}

- (void)freshDataSource
{
    self.page = 1;
    [self requestData];
    self.request.isLoadMore = NO;
}

- (void)loadMoreDataSource
{
    self.page ++;
    [self requestData];
    self.request.isLoadMore = YES;
}

- (void)requestData
{
    NSDictionary *parameters = @{@"currency_id" : self.currencyId ?: @"",
                                 @"page" : @(self.page),
                                 };
    NSMutableDictionary *allparameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [allparameters addEntriesFromDictionary:[TKTools baseParameters]];
    
    TKRequest *request = self.request;
    [request GET:[self p_url] parameters:allparameters];
}

- (NSArray *)parserData:(id)data
{
    if (!data || ![data isKindOfClass:[TKMarketsModel class]]) return [NSArray array];
    
    NSArray *maketsList = [[(TKMarketsModel *)data data] list];
    if (!self.request.isLoadMore) {
        [self updateData:maketsList atSection:0];
    }else {
        [self appendData:maketsList atSection:0];
    }
    return maketsList;
}

- (void)prepareCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    TKMarketsFeedModel *itemModel = [self itemDataForIndexPath:indexPath];
    TKMarketsDetailMarketCell *marketsCell = (TKMarketsDetailMarketCell *)cell;
    marketsCell.marketLabel.text = [NSString stringWithFormat:@"%@,%@",itemModel.market_name,itemModel.pair];
    marketsCell.volumeLabel.text = [self p_amount:itemModel];
    marketsCell.priceLabel.text = itemModel.price_display;
    marketsCell.cnyPriceLabel.text = [self p_cnyPrice:itemModel.price_display_cny];
}

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSString *)p_url
{
    return @"http://118.89.151.44/API/coinprice.php";
}

- (NSString *)p_amount:(TKMarketsFeedModel *)itemModel
{
    return [NSString stringWithFormat:@"%@ %@/%@ %@",[TKBaseAPI formatNumber:[itemModel.volume_24h_from integerValue]],itemModel.currency,[TKBaseAPI formatNumber:[itemModel.volume_24h floatValue]],itemModel.anchor];
}

- (NSString *)p_cnyPrice:(NSString *)string
{
    CGFloat price = [string floatValue];
    NSString *priceStr = (price > 100) ? [NSString stringWithFormat:@"%.2f",price] :
    (price > 0) ? [NSString stringWithFormat:@"%.4f",price] : string;
    return [NSString stringWithFormat:@"≈¥ %@",priceStr];
}

@end
