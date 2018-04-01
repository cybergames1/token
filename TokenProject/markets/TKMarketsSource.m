//
//  TKMarketsSource.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/31.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsSource.h"
#import "TKMarketsModel.h"
#import "TKMarketsCell.h"
#import "UIImageView+WebCache.h"

@implementation TKMarketsSource

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
    UIDevice *device = [UIDevice currentDevice];
    NSString *model = device.model;
    NSString *systemVersion = [NSString stringWithFormat:@"%@ %@", device.systemName, device.systemVersion];
    NSString *deviceUUID = [[device identifierForVendor] UUIDString];
    NSString *code = [TKBaseAPI md5:[NSString stringWithFormat:@"thalesky_eos_%lld",Current_TimeInterval]];
    
    NSDictionary *parameters = @{@"change_type" : @"change_utc0",
                                 @"code" : code,
                                 @"device_model" : model,
                                 @"device_os" : systemVersion,
                                 @"language" : @"zh_CN",
                                 @"legal_currency" : @"CNY",
                                 @"mytoken" : @"d10a54b9c85586a5af9a6218e580ec99",
                                 @"platform" : @"ios",
                                 @"timestamp" : @(Current_TimeInterval),
                                 @"type" : @2,
                                 @"udid" : deviceUUID,
                                 @"v" : @"1.6.5",
                                 @"group_type" : self.marketGroupType ?: @1,
                                 @"id" : self.marketId ?: @0,
                                 @"page" : @1,
                                 @"size" : @20,
                                 };
    
    TKRequest *request = self.request;
    [request GET:@"http://api.lb.mytoken.org/currency/list" parameters:parameters];
}

- (NSArray *)parserData:(id)data
{
    if (!data || ![data isKindOfClass:[TKMarketsModel class]]) return [NSArray array];
    
    NSArray *maketsList = [[(TKMarketsModel *)data data] list];
    [self updateData:maketsList atSection:0];
    return maketsList;
}

- (void)prepareCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    TKMarketsFeedModel *itemModel = [self itemDataForIndexPath:indexPath];
    TKMarketsCell *newsCell = (TKMarketsCell *)cell;
    newsCell.titleLabel.text = [self p_title:itemModel];
    newsCell.marketLabel.text = itemModel.pair;
    newsCell.amountLabel.text = [self p_amount:itemModel];
    [newsCell.iconView sd_setImageWithURL:[NSURL URLWithString:itemModel.logo]];
    newsCell.priceLabel.text = itemModel.price_display;
    newsCell.cnyPriceLabel.text = [self p_cnyPrice:itemModel.price_display_cny];
    newsCell.percentLabel.text = [self p_percent:itemModel.percent_change_display];
    newsCell.percentLabel.backgroundColor = [self p_percent_color:itemModel.percent_change_display];
}

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

/**
 * private method
 */
- (NSString *)p_title:(TKMarketsFeedModel *)itemModel
{
    NSString *alias = (itemModel.alias && [itemModel.alias length] > 0) ? itemModel.alias : itemModel.name;
    return [NSString stringWithFormat:@"%@,%@",itemModel.market_name,alias];
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

- (NSString *)p_percent:(NSString *)string
{
    CGFloat percent = [string floatValue];
    NSString *sign = percent >= 0 ? @"+" : @"";
    return [NSString stringWithFormat:@"%@%.2f",sign,percent];
}

- (UIColor *)p_percent_color:(NSString *)string
{
    CGFloat percent = [string floatValue];
    return (percent >= 0) ? UIColorFromRGB(0x51a938) : UIColorFromRGB(0xbf2828);
}

@end
