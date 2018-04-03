//
//  TKTimeLineNewsSource.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKTimeLineNewsSource.h"
#import "TKTimeLineNewsModel.h"
#import "NSString+TK.h"
#import "TKTimeLineNewsCell.h"

@interface TKTimeLineNewsSource ()

@property (nonatomic, strong) NSString * bottomId;

@end

@implementation TKTimeLineNewsSource

- (id)initWithDelegate:(id<QYPPListViewSourceDelegate>)delegate cellClass:(NSString *)cellClassName cellIdentifier:(NSString *)cellIdentifier cellViewModelType:(NSString *)cellViewModelType
{
    self = [super initWithDelegate:delegate cellClass:cellClassName cellIdentifier:cellIdentifier cellViewModelType:cellViewModelType];
    if (self) {
        [self registerNetRequest:@"TKRequest" responseDataModel:@"TKTimeLineNewsModel"];
    }
    return self;
}

- (void)freshDataSource
{
    NSString *topId = [[NSUserDefaults standardUserDefaults] objectForKey:@"TimeLineNews_top_id"];
    
    NSDictionary *parameters = @{@"limit" : @20,
                                 @"flag" : @"up",
                                 @"id" : topId ?: @"0",
                                 @"version" : @"2.5.0",
                                 };
    
    TKRequest *request = self.request;
    request.isLoadMore = NO;
    [request GET:@"http://api.jinse.com/v3/live/list" parameters:parameters];
}

- (void)loadMoreDataSource
{
    NSDictionary *parameters = @{@"limit" : @20,
                                 @"flag" : @"down",
                                 @"information_id" : self.bottomId ?: @"0",
                                 @"version" : @"2.5.0",
                                 };
    
    TKRequest *request = self.request;
    request.isLoadMore = YES;
    [request GET:@"http://api.jinse.com/v3/live/list" parameters:parameters];
}

- (NSArray *)parserData:(id)data
{
    if (!data || ![data isKindOfClass:[TKTimeLineNewsModel class]]) return [NSArray array];
    
    TKTimeLineNewsModel *model = (TKTimeLineNewsModel *)data;
    self.bottomId = model.bottom_id;
    [[NSUserDefaults standardUserDefaults] setObject:model.top_id ?: @"0" forKey:@"News_top_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (!model.list || model.list.count <= 0) return [NSArray array];
    
    NSArray *newsList = [model.list[0] lives];
    for (TKTimeLineNewsLiveModel *live in newsList) {
        @autoreleasepool {
            NSString *content = live.content;
            CGFloat height = [content heightWithFont:[UIFont systemFontOfSize:16] constraintWidth:SCREEN_WIDTH-43];
            
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[live.created_at longLongValue]];
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.dateFormat = @"YYYY-MM-dd hh:ss";
            NSString *formatTime = [formatter stringFromDate:date];
            
            TKTimeLineNewsLiveViewModel *viewModel = [TKTimeLineNewsLiveViewModel new];
            viewModel.contentHeight = height;
            viewModel.cellHeight = 20+10+13+height+15+23+10;
            viewModel.formatTime = formatTime;
            
            live.viewModel = viewModel;
        }
    }
    if (!self.request.isLoadMore) {
        [self updateData:newsList atSection:0];
    }else {
        [self appendData:newsList atSection:0];
    }
    
    return newsList;
}

- (void)prepareCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    TKTimeLineNewsLiveModel *itemModel = [self itemDataForIndexPath:indexPath];
    TKTimeLineNewsLiveViewModel *viewModel = (TKTimeLineNewsLiveViewModel *)itemModel.viewModel;
    
    TKTimeLineNewsCell *liveCell = (TKTimeLineNewsCell *)cell;
    liveCell.timeLabel.text = viewModel.formatTime;
    liveCell.contentLabel.text = itemModel.content;
    liveCell.upLabel.text = [NSString stringWithFormat:@"利好 %@",itemModel.up_counts];
    liveCell.downLabel.text = [NSString stringWithFormat:@"利空 %@",itemModel.down_counts];
    
    liveCell.contentLabel.height = viewModel.contentHeight;
    liveCell.upLabel.top = liveCell.contentLabel.bottom+13;
    liveCell.downLabel.top = liveCell.upLabel.top;
    liveCell.flagLine.height = viewModel.cellHeight;
}

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath
{
    TKTimeLineNewsLiveModel *item = [self itemDataForIndexPath:indexPath];
    return [(TKTimeLineNewsLiveViewModel *)item.viewModel cellHeight];
}

@end
