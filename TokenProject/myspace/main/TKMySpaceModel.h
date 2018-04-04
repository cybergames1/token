//
//  TKMySpaceModel.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/3.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKModel.h"

@interface TKMySpaceModel : TKModel

NSSTRING_STRONG_OPTIONAL * title;
NSSTRING_STRONG_OPTIONAL * detail;
NSSTRING_STRONG_OPTIONAL * imagePath;

@end

@interface TKMySpaceViewModel : TKModel

@property (nonatomic, assign) CGFloat cellHeight;

@end
