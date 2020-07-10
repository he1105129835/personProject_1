//
//  HNPRegisterVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/4.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPRegisterVC.h"
#import "HNPSendCodeVC.h"

@interface HNPRegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *count_F;
@property (weak, nonatomic) IBOutlet UIButton *YZMBtn;
@property (weak, nonatomic) IBOutlet UILabel *errorLable;
@property (weak, nonatomic) IBOutlet UITextField *codeLable;
@property (weak, nonatomic) IBOutlet UITextField *setPasswordLable;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation HNPRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self textFMonitor];
    [self YZMBtnIsClickEnable];
    [self registerBtnIsClickEnable];
}


#pragma mark - 方法及调用


//获取验证码
- (IBAction)huoquYZMBtn:(id)sender {
    HNPSendCodeVC *sendCodeVC = [HNPSendCodeVC new];
    sendCodeVC.phone = self.count_F.text;
    [self presentViewController:sendCodeVC animated:YES completion:nil];
}

/**为输入框添加监听*/
-(void)textFMonitor{
    [self.count_F addTarget:self action:@selector(YZMBtnIsClickEnable) forControlEvents:UIControlEventEditingChanged];
    [self.codeLable addTarget:self action:@selector(registerBtnIsClickEnable) forControlEvents:UIControlEventEditingChanged];
    [self.setPasswordLable addTarget:self action:@selector(registerBtnIsClickEnable) forControlEvents:UIControlEventEditingChanged];
}
/**验证码按钮状态*/
-(void)YZMBtnIsClickEnable{
    if (self.count_F.text.length >= 11) {
        self.YZMBtn.enabled = YES;
    }else{
        self.YZMBtn.enabled = NO;
    }
//    self.errorLable.hidden = YES;
}
/**注册按钮状态*/
-(void)registerBtnIsClickEnable{
    if (self.count_F.text.length >= 11 && self.codeLable.text.length >= 6 && self.setPasswordLable.text.length >= 1) {
        self.registerBtn.enabled = YES;
    }else{
        self.registerBtn.enabled = NO;
    }
}

//点击屏幕其它地方关闭键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - 数据

- (IBAction)beginRegisterBtnClick:(id)sender {
    //参数
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:self.count_F.text forKey:@"phone"];
    [par setObject:self.setPasswordLable.text forKey:@"password"];
    [par setObject:self.setPasswordLable.text forKey:@"confirmPassword"];
    [par setObject:self.codeLable forKey:@"code"];
    [par setObject:@"1" forKey:@"type"];
    [par setObject:@"futures" forKey:@"project"];
    
    //获取网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://api.yysc.online/system/register" parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *data = responseObject;
        NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
        if ([success isEqualToString:@"1"]) {
            
            [MBProgressHUD showMessage:@"注册成功"];
            //延时执行代码
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                [self dismissViewControllerAnimated:YES completion:nil];
            });
            
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"注册失败"];
        }
        
        
        
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"注册失败"];
        }];
    
};


@end
