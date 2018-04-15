//
//  TKLoginController.m
//  TokenProject
//
//  Created by 刘建廷 on 2018/4/4.
//  Copyright © 2018年 刘建廷. All rights reserved.
//

#import "TKLoginController.h"
#import "TKRegistSource.h"
#import "TKUser.h"

@interface TKLoginController ()
{
    NSInteger _time;
}

@property (nonatomic, strong) UITextField * phoneTextField;
@property (nonatomic, strong) UITextField * codeTextField;
@property (nonatomic, strong) UIButton * getCodeButton;
@property (nonatomic, strong) UIButton * loginButton;
@property (nonatomic, strong) NSTimer * codeTimer;

@end

@implementation TKLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录";
    [self setupNavgationBar];
    [self setupView];
}

- (void)dealloc
{
    [self.codeTimer invalidate];
    self.codeTimer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNavgationBar
{
    self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 0, 50, 44)];
    [back setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [back setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    [back addTarget:self action:@selector(p_goback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setupView
{
    CGFloat top = [TKBaseAPI statusBarAndNavgationBarHeight:self.navigationController];
    UILabel *titleLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(0, 55+top, self.view.width, 13)];
    titleLabel_.textColor = UIColorFromRGB(0x666666);
    titleLabel_.font = [UIFont systemFontOfSize:12];
    titleLabel_.textAlignment = NSTextAlignmentCenter;
    titleLabel_.text = @"验证即可登录，未注册用户将根据手机号自动创建账号";
    
    UITextField *phoneTextField_ = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-304)/2, titleLabel_.bottom+23, 304, 40)];
    phoneTextField_.font = [UIFont systemFontOfSize:15];
    phoneTextField_.placeholder = @"手机号";
    phoneTextField_.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextField_.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTextField = phoneTextField_;
    
    UIView *line1_ = [[UIView alloc] initWithFrame:CGRectMake(phoneTextField_.left, phoneTextField_.bottom, 304, 1)];
    line1_.backgroundColor = UIColorFromRGB(0xe1e1e1);
    
    UITextField *codeTextField_ = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-304)/2, phoneTextField_.bottom+15, 304, 40)];
    codeTextField_.font = [UIFont systemFontOfSize:15];
    codeTextField_.placeholder = @"验证码";
    codeTextField_.keyboardType = UIKeyboardTypeNumberPad;
    codeTextField_.clearButtonMode = UITextFieldViewModeWhileEditing;
    codeTextField_.rightViewMode = UITextFieldViewModeAlways;
    self.codeTextField = codeTextField_;
    
    UIView *line2_ = [[UIView alloc] initWithFrame:CGRectMake(codeTextField_.left, codeTextField_.bottom, 304, 1)];
    line2_.backgroundColor = UIColorFromRGB(0xe1e1e1);
    
    UIButton *getCodeButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
    [getCodeButton_ setFrame:CGRectMake(0, 0, 90, 40)];
    [getCodeButton_ setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateDisabled];
    [getCodeButton_ setTitleColor:UIColorFromRGB(0xe69a37) forState:UIControlStateNormal];
    [getCodeButton_.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [getCodeButton_ setEnabled:NO];
    [getCodeButton_ setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeButton_ addTarget:self action:@selector(p_getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    self.getCodeButton = getCodeButton_;
    self.codeTextField.rightView = getCodeButton_;
    
    UIButton *loginButton_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton_ setFrame:CGRectMake(codeTextField_.left, codeTextField_.bottom+62, 304, 40)];
    [loginButton_ setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateDisabled];
    [loginButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton_ setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton_.layer setCornerRadius:4];
    [loginButton_.layer setMasksToBounds:YES];
    [loginButton_ addTarget:self action:@selector(p_login) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton = loginButton_;
    [self p_setLoginButtonEnable:NO];
    
    [self.view addSubview:titleLabel_];
    [self.view addSubview:_phoneTextField];
    [self.view addSubview:_codeTextField];
    [self.view addSubview:_loginButton];
    [self.view addSubview:line1_];
    [self.view addSubview:line2_];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEnd:) name:UITextFieldTextDidEndEditingNotification object:nil];
}

- (void)textDidChange:(NSNotification *)notification
{
    _getCodeButton.enabled = _phoneTextField.text.length > 0 ? YES : NO;
    [self p_setLoginButtonEnable:(_phoneTextField.text.length > 0 && _codeTextField.text.length > 0) ? YES : NO];
}

- (void)textDidEnd:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    NSLog(@"text end:%@",textField.text);
}

//获取验证码点击事件
- (void)p_getCodeAction:(UIButton *)sender
{
    _time = 59;
    [self p_setCodeTimerIsActing:YES];
    if (self.codeTimer) [self.codeTimer invalidate];
    self.codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(p_getCodeTimerAction) userInfo:nil repeats:YES];
    
    TKRegistSource *source = [[TKRegistSource alloc] init];
    source.mobile = _phoneTextField.text;
    [source requestURL:@"http://118.89.151.44/API/regist.php" success:^(NSURLSessionDataTask *task, id responseObject) {
        //
        NSLog(@"url:%@",task.currentRequest.URL);
        if (!responseObject || ![responseObject isKindOfClass:[NSDictionary class]]) return;

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //
    }];
}

//登录点击事件
- (void)p_login
{
    @weakify(self);
    TKRegistSource *source = [[TKRegistSource alloc] init];
    source.mobile = _phoneTextField.text;
    source.smsCode = _codeTextField.text;
    [source requestloginURL:@"http://118.89.151.44/API/login.php" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"url:%@",task.currentRequest.URL);
        if (!responseObject || ![responseObject isKindOfClass:[NSDictionary class]]) return;
        @strongify(self);
        
        TKUser *user = [TKUser new];
        user.token = responseObject[@"token"];
        user.udid = responseObject[@"udid"];
        user.candy = [NSString stringWithFormat:@"%ld",[responseObject[@"candy"] integerValue]];
        [[TKUserManager sharedManager] setCurrentUser:user];
        [[TKUserManager sharedManager] save];
        
        if (self.loginSuccessBlock) self.loginSuccessBlock();
        [self p_goback];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //
    }];
}

//计时器计时事件
- (void)p_getCodeTimerAction
{
    if (_time <= 1) {
        [self p_setCodeTimerIsActing:NO];
        [self.codeTimer invalidate];
        self.codeTimer = nil;
        return;
    }
    
    _time--;
    [self p_setCodeTimerIsActing:YES];
}

- (void)p_setCodeTimerIsActing:(BOOL)isActing
{
    _getCodeButton.enabled = (!isActing && _phoneTextField.text.length > 0) ? YES : NO;
    if (isActing) {
        [_getCodeButton setTitle:[NSString stringWithFormat:@"%ld",_time] forState:UIControlStateNormal];
    }else {
        [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

//返回按钮事件
- (void)p_goback
{
    [_phoneTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)p_setLoginButtonEnable:(BOOL)enable
{
    self.loginButton.backgroundColor = enable ? UIColorFromRGB(0xe69a37) : UIColorFromRGB(0xdddddd);
    self.loginButton.enabled = enable;
}

@end
