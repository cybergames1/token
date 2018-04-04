//
//  TKMarketsSource.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/31.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsSource.h"
#import "TKMarketsModel.h"
#import "TKMarketsCell.h"
#import "UIImageView+WebCache.h"

@interface TKMarketsSource ()

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation TKMarketsSource

- (id)initWithDelegate:(id<QYPPListViewSourceDelegate>)delegate cellClass:(NSString *)cellClassName cellIdentifier:(NSString *)cellIdentifier cellViewModelType:(NSString *)cellViewModelType
{
    self = [super initWithDelegate:delegate cellClass:cellClassName cellIdentifier:cellIdentifier cellViewModelType:cellViewModelType];
    if (self) {
        [self registerNetRequest:@"TKRequest" responseDataModel:@"TKMarketsModel"];
        self.queue = dispatch_queue_create("mergeRefreshPriceQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)refreshPrice
{
    if (self.viewModelList.count <= 0) return;
    
    NSMutableString *pairlist = [NSMutableString stringWithCapacity:0];
    for (NSInteger i = 0; i < [self.viewModelList[0] count]; i++) {
        @autoreleasepool {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            TKMarketsFeedModel *feed = [self itemDataForIndexPath:indexPath];
            NSString *pair = [NSString stringWithFormat:@"%@_%@_%@_%@",self.tabId,feed.name,feed.currency,feed.anchor];
            [pairlist appendFormat:@"%@,",pair];
        }
    }
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *model = device.model;
    NSString *systemVersion = [NSString stringWithFormat:@"%@ %@", device.systemName, device.systemVersion];
    NSString *deviceUUID = [[device identifierForVendor] UUIDString];
    NSString *code = [TKBaseAPI md5:[NSString stringWithFormat:@"thalesky_eos_%lld",Current_TimeInterval]];
    
    NSDictionary *parameters = @{@"change_type" : @"change_utc0",
                                 @"code" : code,
                                 @"device_model" : model,
                                 @"device_os" : systemVersion,
                                 @"language" : @"zh_CN",
                                 @"legal_currency" : @"CNY",
                                 @"mytoken" : @"d10a54b9c85586a5af9a6218e580ec99",
                                 @"pair_list" : pairlist ?: @"",
                                 @"platform" : @"ios",
                                 @"timestamp" : @(Current_TimeInterval),
                                 @"type" : @2,
                                 @"udid" : deviceUUID,
                                 @"v" : @"1.6.5",
                                 };
    
    @weakify(self);
    TKRequest *request = [TKRequest new];
    [request GET:@"http://api.lb.mytoken.org/currency/refreshprice" parameters:parameters];
    request.success = ^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"request:%@",task.originalRequest.URL);
        @strongify(self);
        if (!responseObject || ![responseObject isKindOfClass:[NSDictionary class]]) return ;
        if (self.viewModelList.count <= 0) return;
        
        NSArray *list = [responseObject objectForKey:@"data"];
        if (!list || [list count] <= 0) return;
        
        dispatch_async(_queue, ^{
            for (NSInteger i = 0; i < [self.viewModelList[0] count]; i++) {
                @autoreleasepool {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                    TKMarketsFeedModel *feed = [self itemDataForIndexPath:indexPath];
                    NSDictionary *dic = list[i];
                    
                    TKMarketsViewModel *vm = [TKMarketsViewModel new];
                    CGFloat lastPrice = [feed.price_display_cny floatValue];
                    CGFloat currPirce = [dic[@"price_display_cny"] floatValue];
                    if (lastPrice > currPirce) {
                        vm.priceState = 2;
                    }else if (lastPrice < currPirce) {
                        vm.priceState = 1;
                    }else {
                        vm.priceState = 0;
                    }
                    feed.price_display = dic[@"price_display"];
                    feed.price_display_cny = dic[@"price_display_cny"];
                    feed.percent_change_display = dic[@"percent_change_display"];
                    feed.viewModel = vm;
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.delegate && [self.delegate respondsToSelector:@selector(listViewSourceDidFinish:)]) {
                    [self.delegate listViewSourceDidFinish:self];
                }
            });
        });
    };
}

- (void)freshDataSource
{
    self.page = 1;
    [self requestData];
    self.request.isLoadMore = NO;
}

- (void)loadMoreDataSource
{
    self.page ++;
    [self requestData];
    self.request.isLoadMore = YES;
}

- (void)requestData
{
    UIDevice *device = [UIDevice currentDevice];
    NSString *model = device.model;
    NSString *systemVersion = [NSString stringWithFormat:@"%@ %@", device.systemName, device.systemVersion];
    NSString *deviceUUID = [[device identifierForVendor] UUIDString];
    NSString *code = [TKBaseAPI md5:[NSString stringWithFormat:@"thalesky_eos_%lld",Current_TimeInterval]];
    
    NSDictionary *parameters = @{@"change_type" : @"change_utc0",
                                 @"code" : code,
                                 @"device_model" : model,
                                 @"device_os" : systemVersion,
                                 @"language" : @"zh_CN",
                                 @"legal_currency" : @"CNY",
                                 @"mytoken" : @"d10a54b9c85586a5af9a6218e580ec99",
                                 @"platform" : @"ios",
                                 @"timestamp" : @(Current_TimeInterval),
                                 @"type" : @2,
                                 @"udid" : deviceUUID,
                                 @"v" : @"1.6.5",
                                 @"group_type" : self.marketGroupType ?: @1,
                                 @"id" : self.marketId ?: @0,
                                 @"page" : @(self.page),
                                 @"size" : @20,
                                 };
    
    TKRequest *request = self.request;
    [request GET:@"http://api.lb.mytoken.org/currency/list" parameters:parameters];
}

- (NSArray *)parserData:(id)data
{
    if (!data || ![data isKindOfClass:[TKMarketsModel class]]) return [NSArray array];
    
    NSArray *maketsList = [[(TKMarketsModel *)data data] list];
    if (!self.request.isLoadMore) {
        [self updateData:maketsList atSection:0];
    }else {
        [self appendData:maketsList atSection:0];
    }
    
    return maketsList;
}

- (void)prepareCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    TKMarketsFeedModel *itemModel = [self itemDataForIndexPath:indexPath];
    TKMarketsViewModel *viewModel = (TKMarketsViewModel *)itemModel.viewModel;
    TKMarketsCell *marketsCell = (TKMarketsCell *)cell;
    marketsCell.titleLabel.text = [self p_title:itemModel];
    marketsCell.marketLabel.text = itemModel.pair;
    marketsCell.amountLabel.text = [self p_amount:itemModel];
    [marketsCell.iconView sd_setImageWithURL:[NSURL URLWithString:itemModel.logo]];
    marketsCell.priceLabel.text = itemModel.price_display;
    marketsCell.cnyPriceLabel.text = [self p_cnyPrice:itemModel.price_display_cny];
    marketsCell.percentLabel.text = [self p_percent:itemModel.percent_change_display];
    marketsCell.percentLabel.backgroundColor = [self p_percent_color:itemModel.percent_change_display];
    marketsCell.priceState = viewModel.priceState;
}

- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

/**
 * private method
 */
- (NSString *)p_title:(TKMarketsFeedModel *)itemModel
{
    NSString *alias = (itemModel.alias && [itemModel.alias length] > 0) ? itemModel.alias : itemModel.name;
    return [NSString stringWithFormat:@"%@,%@",itemModel.market_name,alias];
}
- (NSString *)p_amount:(TKMarketsFeedModel *)itemModel
{
   return [NSString stringWithFormat:@"%@ %@/%@ %@",[TKBaseAPI formatNumber:[itemModel.volume_24h_from integerValue]],itemModel.currency,[TKBaseAPI formatNumber:[itemModel.volume_24h floatValue]],itemModel.anchor];
}

- (NSString *)p_cnyPrice:(NSString *)string
{
    CGFloat price = [string floatValue];
    NSString *priceStr = (price > 100) ? [NSString stringWithFormat:@"%.2f",price] :
                         (price > 0) ? [NSString stringWithFormat:@"%.4f",price] : string;
    return [NSString stringWithFormat:@"≈¥ %@",priceStr];
}

- (NSString *)p_percent:(NSString *)string
{
    CGFloat percent = [string floatValue];
    NSString *sign = percent >= 0 ? @"+" : @"";
    return [NSString stringWithFormat:@"%@%.2f",sign,percent];
}

- (UIColor *)p_percent_color:(NSString *)string
{
    CGFloat percent = [string floatValue];
    return (percent >= 0) ? UIColorFromRGB(0x51a938) : UIColorFromRGB(0xbf2828);
}

@end
