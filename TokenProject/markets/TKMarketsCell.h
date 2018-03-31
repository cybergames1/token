//
//  TKMarketsCell.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/31.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKMarketsCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * marketLabel;
@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) UILabel * amountLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * cnyPriceLabel;
@property (nonatomic, strong) UILabel * percentLabel;

@end
