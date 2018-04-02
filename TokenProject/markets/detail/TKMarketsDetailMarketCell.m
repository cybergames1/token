//
//  TKMarketsDetailMarketCell.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsDetailMarketCell.h"

@implementation TKMarketsDetailMarketCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    UILabel *marketLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(14, 10, 141, 15)];
    marketLabel_.font = [UIFont systemFontOfSize:13];
    self.marketLabel = marketLabel_;
    
    UILabel *volumeLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(marketLabel_.frame)+7, 180, 12)];
    volumeLabel_.font = [UIFont systemFontOfSize:13];
    volumeLabel_.textColor = UIColorFromRGB(0xcbcbcb);
    self.volumeLabel = volumeLabel_;
    
    UILabel *priceLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-200, 10, 185, 15)];
    priceLabel_.font = [UIFont systemFontOfSize:13];
    priceLabel_.textAlignment = NSTextAlignmentRight;
    self.priceLabel = priceLabel_;
    
    UILabel *cnyPriceLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-200, CGRectGetMaxY(priceLabel_.frame)+7, 185, 12)];
    cnyPriceLabel_.font = [UIFont systemFontOfSize:13];
    cnyPriceLabel_.textAlignment = NSTextAlignmentRight;
    cnyPriceLabel_.textColor = UIColorFromRGB(0xcbcbcb);
    self.cnyPriceLabel = cnyPriceLabel_;
    
    UIView *line_ = [[UIView alloc] initWithFrame:CGRectMake(15, 55-0.5, SCREEN_WIDTH-30, 0.5)];
    line_.backgroundColor = UIColorFromRGB(0xe1e1e1);
    
    [self addSubview:self.marketLabel];
    [self addSubview:self.volumeLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.cnyPriceLabel];
    [self addSubview:line_];
}


@end
