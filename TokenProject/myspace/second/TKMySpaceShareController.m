//
//  TKMySpaceShareController.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/4.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKMySpaceShareController.h"

@interface TKMySpaceShareController ()

@property (nonatomic, strong) UIView * topView;

@end

@implementation TKMySpaceShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.title = @"推荐我们";
    [self setupView];
}

- (void)setupView
{
    [self setupTopView];
    [self setupBottomView];
}

- (void)setupTopView
{
    CGFloat top = [TKBaseAPI statusBarAndNavgationBarHeight:self.navigationController];
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, top, self.view.width, 261)];
    topView.backgroundColor = UIColorFromRGB(0xaad7ef);
    self.topView = topView;
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 16, 76, 76)];
    icon.image = [UIImage imageNamed:@"logo_about"];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, icon.bottom+15, 110, 18)];
    title.font = [UIFont boldSystemFontOfSize:18];
    title.text = @"TokenTime:";
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle};
    NSMutableAttributedString *newsString = [[NSMutableAttributedString alloc] initWithString:@"币圈动态\n最新消息\n行情分析\n……" attributes:attriDict];
    
    UILabel *news = [[UILabel alloc] initWithFrame:CGRectMake(title.right+11, title.top-3, 130, 120)];
    news.font = [UIFont systemFontOfSize:21];
    news.attributedText = newsString;
    news.lineBreakMode = NSLineBreakByWordWrapping;
    news.numberOfLines = 4;
    
    NSMutableAttributedString *infoString = [[NSMutableAttributedString alloc] initWithString:@"早一点使用TokenTime，早一步迈入通证时代"];
    [infoString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(5, 9)];
    UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(20, topView.height-25, topView.width, 16)];
    info.font = [UIFont systemFontOfSize:16];
    info.attributedText = infoString;
    
    [topView addSubview:icon];
    [topView addSubview:title];
    [topView addSubview:news];
    [topView addSubview:info];
    
    [self.view addSubview:topView];
}

- (void)setupBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _topView.bottom, self.view.width, self.view.height-_topView.bottom)];
    bottomView.backgroundColor = self.view.backgroundColor;
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 9;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle};
    NSMutableAttributedString *infoString = [[NSMutableAttributedString alloc] initWithString:@"扫描下载TokenTime查看完整资讯\n错过了互联网，不要错过区块链" attributes:attriDict];
    [infoString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(4, 9)];
    UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(0, bottomView.height-70, bottomView.width, 50)];
    info.font = [UIFont systemFontOfSize:16];
    info.attributedText = infoString;
    info.lineBreakMode = NSLineBreakByWordWrapping;
    info.numberOfLines = 2;
    
    [bottomView addSubview:info];
    
    [self.view addSubview:bottomView];
}

@end
