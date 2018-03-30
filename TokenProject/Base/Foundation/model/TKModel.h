//
//  TKModel.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/29.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

/** 自动定义 NSString **/
#define NSSTRING_STRONG_OPTIONAL  @property (nonatomic, strong) NSString<Optional>
#define NSSTRING_COPY_OPTIONAL  @property (nonatomic, copy) NSString<Optional>

/** 自动定义 NSNumber **/
#define NSNUMBER_STRONG_OPTIONAL  @property (nonatomic, copy) NSNumber<Optional>

/** 自动定义 NSArray **/
#define NSARRAY_STRONG_OPTIONAL  @property (nonatomic, strong) NSArray<Optional,ConvertOnDemand>

/** 自动定义任意 Object **/
#define OBJECT_STRONG_OPTIONAL(obj)  @property (nonatomic, strong) obj<Optional>

/** 自动定义任意元素为 Object 的 NSArray **/
#define NSARRAY_OBJECT_STRONG_OPTIONAL(obj) @property (nonatomic, strong) NSArray<Optional,obj>

@interface TKModel : JSONModel

OBJECT_STRONG_OPTIONAL(JSONModel) * viewModel;

@end
