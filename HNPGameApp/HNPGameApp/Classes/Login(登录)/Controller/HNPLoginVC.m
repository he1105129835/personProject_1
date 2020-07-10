//
//  HNPLoginVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/4.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPLoginVC.h"
#import "HNPRegisterVC.h"
#import "HNPMyPersonVC.h"
#import "HNPPersonModel.h"

@interface HNPLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *count_F;
@property (weak, nonatomic) IBOutlet UITextField *password_F;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *errorLable;

@end

@implementation HNPLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self textFMonitor];
    [self loginBtnIsClickEnable];
}

#pragma mark - 方法

/**为输入框添加监听*/
-(void)textFMonitor{
    [self.count_F addTarget:self action:@selector(loginBtnIsClickEnable) forControlEvents:UIControlEventEditingChanged];
    [self.password_F addTarget:self action:@selector(loginBtnIsClickEnable) forControlEvents:UIControlEventEditingChanged];
}

-(void)loginBtnIsClickEnable{
    if (self.count_F.text.length >= 11 && self.password_F.text.length >= 1) {
        self.loginBtn.enabled = YES;
    }else{
        self.loginBtn.enabled = NO;
    }
    self.errorLable.hidden = YES;
}

- (IBAction)rigesterBtn:(id)sender {
    HNPRegisterVC *registerVC = [HNPRegisterVC new];
    [self presentViewController:registerVC animated:YES completion:nil];
}

//点击屏幕其它地方关闭键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)loginBtnClick:(UIButton *)sender {
    
    [MBProgressHUD showMessage:@"正在登录，请稍后..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self beginLogin];
    });
}

#pragma mark - 登录

-(void)beginLogin{
    NSMutableDictionary *loginPar = [NSMutableDictionary new];
    [loginPar setObject:self.count_F.text forKey:@"phone"];
    [loginPar setObject:self.password_F.text forKey:@"password"];
    [loginPar setObject:@"1" forKey:@"type"];
    [loginPar setObject:@"futures" forKey:@"project"];
    [loginPar setObject:@"000000" forKey:@"code"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.yysc.online/system/login" parameters:loginPar progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = responseObject;
        NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
        NSDictionary *dict = data[@"data"];
        if ([success isEqualToString:@"1"]) {
            [MBProgressHUD showMessage:@"登录成功..."];
            HNPPersonModel *perModel = [HNPPersonModel HNPPersonModelWithDict:dict];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
                NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
                NSDictionary *tempDict = [perModel mj_keyValues];
                [tempDict writeToFile:path atomically:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:self];
//                NSLog(@"%@",NSHomeDirectory());
            
                                   
        });
    }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"登录未成功"];
        self.errorLable.hidden = NO;
                           }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



@end
