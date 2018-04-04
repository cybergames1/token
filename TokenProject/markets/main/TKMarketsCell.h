//
//  TKMarketsCell.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/31.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TKMarketsPriceState) {
    TKMarketsPriceStateNormal = 0, //价格没变
    TKMarketsPriceStateUp = 1, //价格涨了
    TKMarketsPriceStateDown = 2, //价格跌了
};

@interface TKMarketsCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * marketLabel;
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) UILabel * amountLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * cnyPriceLabel;
@property (nonatomic, strong) UILabel * percentLabel;

@property (nonatomic, assign) TKMarketsPriceState priceState;

@end
