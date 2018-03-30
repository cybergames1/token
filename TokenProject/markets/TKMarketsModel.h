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

@protocol TKMarketsTopNavModel;
@interface TKMarketsDataModel: TKModel

NSARRAY_OBJECT_STRONG_OPTIONAL(TKMarketsTopNavModel) * list;

@end

@interface TKMarketsTopNavModel : TKModel

NSNUMBER_STRONG_OPTIONAL * smart_group_type;
NSSTRING_STRONG_OPTIONAL * smart_group_name;
NSSTRING_STRONG_OPTIONAL * name;
NSNUMBER_STRONG_OPTIONAL * marketId;
NSNUMBER_STRONG_OPTIONAL * group_type;
NSNUMBER_STRONG_OPTIONAL * smart_group_id;
NSNUMBER_STRONG_OPTIONAL * weight;
NSNUMBER_STRONG_OPTIONAL * enabled;
NSSTRING_STRONG_OPTIONAL * user_id;
NSNUMBER_STRONG_OPTIONAL * is_default;
NSNUMBER_STRONG_OPTIONAL * is_deleted;
NSSTRING_STRONG_OPTIONAL * created_at;

@end
