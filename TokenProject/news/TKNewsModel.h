//
//  TKNewsModel.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/29.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKModel.h"


@protocol TKNewsSingleModel;
@interface TKNewsModel : TKModel

NSNUMBER_STRONG_OPTIONAL * news;
NSNUMBER_STRONG_OPTIONAL * count;
NSSTRING_STRONG_OPTIONAL * top_id;
NSSTRING_STRONG_OPTIONAL * bottom_id;
NSARRAY_OBJECT_STRONG_OPTIONAL(TKNewsSingleModel) * list;
@end

@class TKNewsSingleExtraModel;
@interface TKNewsSingleModel : TKModel

NSSTRING_STRONG_OPTIONAL * newsId;
NSSTRING_STRONG_OPTIONAL * title;
NSNUMBER_STRONG_OPTIONAL * type;
OBJECT_STRONG_OPTIONAL(TKNewsSingleExtraModel) * extra;

@end

@interface TKNewsSingleExtraModel : TKModel

NSSTRING_STRONG_OPTIONAL * version;
NSSTRING_STRONG_OPTIONAL * summary;
OBJECT_STRONG_OPTIONAL(NSDate) * publishedTime;
NSSTRING_STRONG_OPTIONAL * author;
NSNUMBER_STRONG_OPTIONAL * author_level;
NSSTRING_STRONG_OPTIONAL * read_number;
NSSTRING_STRONG_OPTIONAL * thumbnail_pic;
NSSTRING_STRONG_OPTIONAL * source;
NSSTRING_STRONG_OPTIONAL * topic_url;
NSSTRING_STRONG_OPTIONAL * attribute_exclusive;
NSSTRING_STRONG_OPTIONAL * attribute_depth;

@end
