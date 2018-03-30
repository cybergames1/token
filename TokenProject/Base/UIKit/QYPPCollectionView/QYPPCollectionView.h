//
//  QYPPCollectionView.h
//  paopao_ios
//
//  Created by jianting on 16/5/26.
//  Copyright © 2016年 ___multiMedia___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface QYPPCollectionView : UICollectionView

/** 是否有下拉刷新 **/
@property (nonatomic) BOOL showPullRefresh;
/** 是否有加载更多 **/
@property (nonatomic) BOOL showPushLoadMore;

@end
