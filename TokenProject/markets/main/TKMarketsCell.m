//
//  TKMarketsCell.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/31.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsCell.h"

@implementation TKMarketsCell

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
    UILabel *titleLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(14, 8, 161, 12)];
    titleLabel_.font = [UIFont systemFontOfSize:12];
    titleLabel_.textColor = UIColorFromRGB(0xcbcbcb);
    self.titleLabel = titleLabel_;
    
    UIImageView *iconView_ = [[UIImageView alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(titleLabel_.frame)+7, 20, 20)];
    self.iconView = iconView_;
    
    UILabel *marketLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconView_.frame)+5, CGRectGetMinY(iconView_.frame), 141, 20)];
    marketLabel_.font = [UIFont systemFontOfSize:14];
    self.marketLabel = marketLabel_;
    
    UILabel *amountLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(iconView_.frame)+7, 180, 12)];
    amountLabel_.font = [UIFont systemFontOfSize:12];
    amountLabel_.textColor = UIColorFromRGB(0xcbcbcb);
    self.amountLabel = amountLabel_;
    
    UILabel *priceLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-200, 29, 107, 20)];
    priceLabel_.font = [UIFont systemFontOfSize:14];
    priceLabel_.textAlignment = NSTextAlignmentRight;
    self.priceLabel = priceLabel_;
    
    UILabel *cnyPriceLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-200, CGRectGetMaxY(priceLabel_.frame)+6, 107, 12)];
    cnyPriceLabel_.font = [UIFont systemFontOfSize:12];
    cnyPriceLabel_.textAlignment = NSTextAlignmentRight;
    cnyPriceLabel_.textColor = UIColorFromRGB(0xcbcbcb);
    self.cnyPriceLabel = cnyPriceLabel_;
    
    UILabel *percentLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-82, 23, 72, 30)];
    percentLabel_.font = [UIFont systemFontOfSize:14];
    percentLabel_.textAlignment = NSTextAlignmentCenter;
    percentLabel_.textColor = [UIColor whiteColor];
    percentLabel_.layer.cornerRadius = 2;
    percentLabel_.layer.masksToBounds = YES;
    self.percentLabel = percentLabel_;
    
    UIView *line_ = [[UIView alloc] initWithFrame:CGRectMake(15, 75-0.5, SCREEN_WIDTH-30, 0.5)];
    line_.backgroundColor = UIColorFromRGB(0xe1e1e1);
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.iconView];
    [self addSubview:self.marketLabel];
    [self addSubview:self.amountLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.cnyPriceLabel];
    [self addSubview:self.percentLabel];
    [self addSubview:line_];
}

- (void)setPriceState:(TKMarketsPriceState)priceState
{
    if (_priceState == priceState) return;
    _priceState = priceState;
    
    if (priceState == TKMarketsPriceStateUp) {
        self.priceLabel.textColor = UIColorFromRGB(0x51a938);
    }else if (priceState == TKMarketsPriceStateDown) {
        self.priceLabel.textColor = UIColorFromRGB(0xbf2828);
    }else {
        //
    }
    
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        self.priceLabel.textColor = [UIColor blackColor];
    });
}


@end
