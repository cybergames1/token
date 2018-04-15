//
//  TKMarketsDetailExchangeListSource.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsDetailExchangeListSource.h"
#import "TKMarketsModel.h"
#import "TKMarketsDetailExchangeCell.h"
#import "UIImageView+WebCache.h"

@implementation TKMarketsDetailExchangeListSource

- (void)prepareCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    TKMarketsFeedModel *itemModel = [self itemDataForIndexPath:indexPath];
    TKMarketsDetailExchangeCell *marketsCell = (TKMarketsDetailExchangeCell *)cell;
    marketsCell.indexPath = indexPath;
    marketsCell.delegate = (id)self.delegate;
    marketsCell.marketLabel.text = [NSString stringWithFormat:@"%@,%@",itemModel.alias,itemModel.market_name];
    marketsCell.volumeLabel.text = itemModel.website;
    marketsCell.priceLabel.text = [NSString stringWithFormat:@"%@,额(24h)",itemModel.pair];
    marketsCell.cnyPriceLabel.text = [NSString stringWithFormat:@"$%@",itemModel.volume_24h];
    [marketsCell.iconView sd_setImageWithURL:[NSURL URLWithString:itemModel.flag]];
}

- (NSString *)p_url
{
    return @"http://118.89.151.44/API/market.php";
}

@end
