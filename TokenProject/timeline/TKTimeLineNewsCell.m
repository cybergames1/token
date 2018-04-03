//
//  TKTimeLineNewsCell.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/2.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKTimeLineNewsCell.h"

@implementation TKTimeLineNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    UIView *line_ = [[UIView alloc] initWithFrame:CGRectMake(18, 0, 1, 0.5)];
    line_.backgroundColor = UIColorFromRGB(0xe1e1e1);
    self.flagLine = line_;
    
    UIView *flag_big_ = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 10, 10)];
    flag_big_.backgroundColor = UIColorFromRGB(0xf5dfb5);
    flag_big_.layer.cornerRadius = 5;
    flag_big_.layer.masksToBounds = YES;
    flag_big_.centerX = line_.centerX;
    
    UIView *flag_small_ = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    flag_small_.backgroundColor = UIColorFromRGB(0xe69a37);
    flag_small_.layer.cornerRadius = 2.5;
    flag_small_.layer.masksToBounds = YES;
    flag_small_.center = flag_big_.center;
    
    UILabel *timeLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(line_.right+10, flag_big_.top, 200, 10)];
    timeLabel_.font = [UIFont systemFontOfSize:10];
    timeLabel_.textColor = UIColorFromRGB(0xa8b0c0);
    self.timeLabel = timeLabel_;
    
    UILabel *contentLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(timeLabel_.left, flag_big_.bottom+13, SCREEN_WIDTH-timeLabel_.left-15, 0)];
    contentLabel_.font = [UIFont systemFontOfSize:16];
    contentLabel_.lineBreakMode = NSLineBreakByCharWrapping;
    contentLabel_.numberOfLines = 0;
    self.contentLabel = contentLabel_;
    
    UILabel *upLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(timeLabel_.left, contentLabel_.bottom+15, 63, 23)];
    upLabel_.font = [UIFont systemFontOfSize:12];
    upLabel_.backgroundColor = UIColorFromRGB(0xfdf3f2);
    upLabel_.layer.cornerRadius = 11.5;
    upLabel_.layer.borderWidth = 1.0;
    upLabel_.layer.borderColor = UIColorFromRGB(0xec4b43).CGColor;
    upLabel_.textColor = UIColorFromRGB(0xec4b43);
    upLabel_.textAlignment = NSTextAlignmentCenter;
    self.upLabel = upLabel_;
    
    UILabel *downLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(upLabel_.right+10, upLabel_.top, 63, 23)];
    downLabel_.font = [UIFont systemFontOfSize:12];
    downLabel_.backgroundColor = UIColorFromRGB(0xf2faf4);
    downLabel_.layer.cornerRadius = 11.5;
    downLabel_.layer.borderWidth = 1.0;
    downLabel_.layer.borderColor = UIColorFromRGB(0x63bc79).CGColor;
    downLabel_.textColor = UIColorFromRGB(0x63bc79);
    downLabel_.textAlignment = NSTextAlignmentCenter;
    self.downLabel = downLabel_;
    
    
    [self addSubview:self.flagLine];
    [self addSubview:flag_big_];
    [self addSubview:flag_small_];
    [self addSubview:self.timeLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.upLabel];
    [self addSubview:self.downLabel];
}
@end
