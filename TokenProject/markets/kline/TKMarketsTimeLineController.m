//
//  TKMarketsTimeLineController.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/6.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMarketsTimeLineController.h"
#import "YYStock.h"
#import "YYStockVariable.h"
#import <Masonry/Masonry.h>
#import "TKMarketsTimeLineSource.h"
#import "TKMarketsTimeLineModel.h"

@interface TKMarketsTimeLineController () <YYStockDataSource>

@property (strong, nonatomic) YYStock *stock;

@property (strong, nonatomic) NSMutableDictionary *stockDatadict;

@end

@implementation TKMarketsTimeLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    [self initStockView];
    [self fetchData];
}

- (void)initStockView
{
    [YYStockVariable setStockLineWidthArray:@[@6,@6,@6,@6]];
    
    YYStock *stock = [[YYStock alloc]initWithFrame:self.view.frame dataSource:self];
    self.stock = stock;
    [self.view addSubview:stock.mainView];
    [stock.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)fetchData
{
    @weakify(self);
    TKMarketsTimeLineSource *source = [[TKMarketsTimeLineSource alloc] init];
    source.pairId = self.pairId;
    source.marketId = self.marketId;
    [source requestTimeLineURL:@"http://api.lb.mytoken.org/currency/trend" success:^(NSURLSessionDataTask *task, id responseObject) {
        @strongify(self);
        if (!responseObject || ![responseObject isKindOfClass:[NSDictionary class]]) return ;
        NSArray *klinelist = responseObject[@"data"][@"kline"];
        if (!klinelist || ![klinelist isKindOfClass:[NSArray class]] || klinelist.count <= 0) return;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        [klinelist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool {
                TKMarketsTimeLineModel *model = [[TKMarketsTimeLineModel alloc] initWithDict:obj];
                [array addObject:model];
            }
        }];
        [self.stockDatadict setObject:array forKey:@"TimeLineList"];
        [self.stock draw];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //
    }];
}

-(NSArray <NSString *> *) titleItemsOfStock:(YYStock *)stock {
    return @[@"1"];
}

-(NSArray *) YYStock:(YYStock *)stock stockDatasOfIndex:(NSInteger)index {
    return self.stockDatadict[@"TimeLineList"];
}

- (id<YYStockFiveRecordProtocol>)fiveRecordModelOfIndex:(NSInteger)index {
    return nil;
}

-(YYStockType)stockTypeOfIndex:(NSInteger)index {
    return YYStockTypeTimeLine;
}

- (BOOL)isShowfiveRecordModelOfIndex:(NSInteger)index {
    return NO;
}

@end
