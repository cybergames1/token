//
//  TKMarketsDetailExchangeCell.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsDetailExchangeCell.h"

@implementation TKMarketsDetailExchangeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addView];
    }
    return self;
}

- (void)addView
{
    UIImageView *iconView_ = [[UIImageView alloc] initWithFrame:CGRectMake(14, 19, 18, 18)];
    iconView_.backgroundColor = UIColorFromRGB(0xcbcbcb);
    iconView_.layer.cornerRadius = 9;
    iconView_.layer.masksToBounds = YES;
    self.iconView = iconView_;
    [self addSubview:self.iconView];
    
    self.marketLabel.left += 25;
    self.volumeLabel.left += 25;
    
    self.marketLabel.textColor = UIColorFromRGB(0xcbcbcb);
    self.volumeLabel.textColor = UIColorFromRGB(0x3584f7);
    self.priceLabel.textColor = UIColorFromRGB(0xcbcbcb);
    self.cnyPriceLabel.textColor = [UIColor blackColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:self.volumeLabel.frame];
    [button addTarget:self action:@selector(urlTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return NO;
}

- (void)urlTap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(urlActionAtCell:)]) {
        [self.delegate urlActionAtCell:self];
    }
}
@end
