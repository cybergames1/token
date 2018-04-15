//
//  TKLoginController.h
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/4.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 登录注册页面
 */

typedef void(^loginSuccessBlock)(void);

@interface TKLoginController : UIViewController

@property (nonatomic, copy) loginSuccessBlock loginSuccessBlock;

@end
