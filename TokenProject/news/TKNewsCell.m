//
//  TKNewsCell.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/3/30.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKNewsCell.h"

@interface TKNewsCell ()



@end

@implementation TKNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    UILabel *titleLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 208, 42)];
    titleLabel_.font = [UIFont systemFontOfSize:17];
    titleLabel_.lineBreakMode = NSLineBreakByCharWrapping;
    titleLabel_.numberOfLines = 2;
    self.titleLabel = titleLabel_;
    
    UILabel *timeLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLabel_.frame)+14, 208, 12)];
    timeLabel_.font = [UIFont systemFontOfSize:12];
    timeLabel_.textColor = UIColorFromRGB(0xcbcbcb);
    self.timeAuthorLabel = timeLabel_;
    
    UIImageView *imageView_ = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-131, 15, 115, 71)];
    imageView_.layer.cornerRadius = 3.0;
    imageView_.layer.masksToBounds = YES;
    imageView_.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageView = imageView_;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.timeAuthorLabel];
    [self addSubview:self.picImageView];
}

@end
