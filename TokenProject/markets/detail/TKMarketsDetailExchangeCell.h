//
//  TKMarketsDetailExchangeCell.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsDetailMarketCell.h"

@protocol TKMarketsDetailExchangeCellDelegate;
@interface TKMarketsDetailExchangeCell : TKMarketsDetailMarketCell <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, weak) id<TKMarketsDetailExchangeCellDelegate> delegate;

@end

@protocol TKMarketsDetailExchangeCellDelegate <NSObject>

- (void)urlActionAtCell:(TKMarketsDetailExchangeCell *)cell;

@end
