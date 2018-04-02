//
//  TKMarketsModel.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/29.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKModel.h"

@class TKMarketsDataModel;
@interface TKMarketsModel : TKModel

NSNUMBER_STRONG_OPTIONAL * code;
NSSTRING_STRONG_OPTIONAL * message;
NSNUMBER_STRONG_OPTIONAL * timestamp;
OBJECT_STRONG_OPTIONAL(TKMarketsDataModel) * data;

@end

@protocol TKMarketsFeedModel;
@interface TKMarketsDataModel: TKModel

NSARRAY_OBJECT_STRONG_OPTIONAL(TKMarketsFeedModel) * list;

@end

@interface TKMarketsFeedModel : TKModel

NSSTRING_STRONG_OPTIONAL * smart_group_type;
NSSTRING_STRONG_OPTIONAL * smart_group_name;
NSSTRING_STRONG_OPTIONAL * name;
NSSTRING_STRONG_OPTIONAL * c_id;
NSSTRING_STRONG_OPTIONAL * group_type;
NSSTRING_STRONG_OPTIONAL * smart_group_id;
NSSTRING_STRONG_OPTIONAL * weight;
NSNUMBER_STRONG_OPTIONAL * enabled;
NSSTRING_STRONG_OPTIONAL * user_id;
NSNUMBER_STRONG_OPTIONAL * is_default;
NSNUMBER_STRONG_OPTIONAL * is_deleted;
NSSTRING_STRONG_OPTIONAL * created_at;

NSSTRING_STRONG_OPTIONAL * alias;
NSSTRING_STRONG_OPTIONAL * pair;
NSSTRING_STRONG_OPTIONAL * rank;
NSSTRING_STRONG_OPTIONAL * logo;
NSSTRING_STRONG_OPTIONAL * market_id;
NSSTRING_STRONG_OPTIONAL * market_name;
NSSTRING_STRONG_OPTIONAL * currency_id;
NSSTRING_STRONG_OPTIONAL * currency;
NSSTRING_STRONG_OPTIONAL * symbol;
NSSTRING_STRONG_OPTIONAL * anchor;
NSSTRING_STRONG_OPTIONAL * volume_24h;
NSSTRING_STRONG_OPTIONAL * volume_24h_from;
NSSTRING_STRONG_OPTIONAL * price_display;
NSSTRING_STRONG_OPTIONAL * price_display_cny;
NSSTRING_STRONG_OPTIONAL * percent_change_display;
NSNUMBER_STRONG_OPTIONAL * is_favorite;

NSSTRING_STRONG_OPTIONAL * cmc_url;
NSSTRING_STRONG_OPTIONAL * website;
NSSTRING_STRONG_OPTIONAL * twitter;
NSSTRING_STRONG_OPTIONAL * twitter_name;
NSSTRING_STRONG_OPTIONAL * flag;

@end
