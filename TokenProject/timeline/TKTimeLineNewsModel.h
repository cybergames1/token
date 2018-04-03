//
//  TKTimeLineNewsModel.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKModel.h"

@protocol TKTimeLineNewsSectionModel;
@interface TKTimeLineNewsModel : TKModel

NSNUMBER_STRONG_OPTIONAL * news;
NSNUMBER_STRONG_OPTIONAL * count;
NSSTRING_STRONG_OPTIONAL * top_id;
NSSTRING_STRONG_OPTIONAL * bottom_id;
NSARRAY_OBJECT_STRONG_OPTIONAL(TKTimeLineNewsSectionModel) * list;

@end

@protocol TKTimeLineNewsLiveModel;
@interface TKTimeLineNewsSectionModel : TKModel

NSSTRING_STRONG_OPTIONAL * date;
NSARRAY_OBJECT_STRONG_OPTIONAL(TKTimeLineNewsLiveModel) * lives;

@end

@interface TKTimeLineNewsLiveModel : TKModel

NSSTRING_STRONG_OPTIONAL * liveId;
NSSTRING_STRONG_OPTIONAL * content;
NSSTRING_STRONG_OPTIONAL * link_name;
NSSTRING_STRONG_OPTIONAL * link;
NSSTRING_STRONG_OPTIONAL * grade;
NSSTRING_STRONG_OPTIONAL * sort;
NSSTRING_STRONG_OPTIONAL * highlight_color;
NSSTRING_STRONG_OPTIONAL * created_at;
NSSTRING_STRONG_OPTIONAL * up_counts;
NSSTRING_STRONG_OPTIONAL * down_counts;
NSSTRING_STRONG_OPTIONAL * zan_status;

@end

@interface TKTimeLineNewsLiveViewModel : TKModel

@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) NSString * formatTime;

@end
