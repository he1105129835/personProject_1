//
//  HNPResetPasswordVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/17.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPResetPasswordVC.h"
#import "HNPSendCodeVC.h"

@interface HNPResetPasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *count_F;
@property (weak, nonatomic) IBOutlet UITextField *code_F;
@property (weak, nonatomic) IBOutlet UITextField *resetPassword_F;
@property (weak, nonatomic) IBOutlet UIButton *YZMBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;

@end

@implementation HNPResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self textFMonitor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - Navigation

- (IBAction)huoquYZMBtn:(id)sender {
    HNPSendCodeVC *sendCodeVC = [HNPSendCodeVC new];
    sendCodeVC.phone = self.count_F.text;
    sendCodeVC.type = 1;
    [self presentViewController:sendCodeVC animated:YES completion:nil];
}
/**为输入框添加监听*/
-(void)textFMonitor{
    [self.count_F addTarget:self action:@selector(YZMBtnIsClickEnable) forControlEvents:UIControlEventEditingChanged];
    [self.code_F addTarget:self action:@selector(registerBtnIsClickEnable) forControlEvents:UIControlEventEditingChanged];
    [self.resetPassword_F addTarget:self action:@selector(registerBtnIsClickEnable) forControlEvents:UIControlEventEditingChanged];
}
/**验证码按钮状态*/
-(void)YZMBtnIsClickEnable{
    if (self.count_F.text.length >= 11) {
        self.YZMBtn.enabled = YES;
    }else{
        self.YZMBtn.enabled = NO;
    }
}
/**注册按钮状态*/
-(void)registerBtnIsClickEnable{
    if (self.count_F.text.length >= 11 && self.code_F.text.length >= 6 && self.resetPassword_F.text.length >= 1) {
        self.resetBtn.enabled = YES;
    }else{
        self.resetBtn.enabled = NO;
    }
}

- (IBAction)resetPasswordBtn:(id)sender {
    NSMutableDictionary *tempPar = [NSMutableDictionary new];
    [tempPar setObject:self.count_F.text forKey:@"phone"];
    [tempPar setObject:self.resetPassword_F.text forKey:@"newPassword"];
    [tempPar setObject:self.resetPassword_F.text forKey:@"confirmPassword"];
    [tempPar setObject:self.code_F.text forKey:@"code"];
    [tempPar setObject:@"game" forKey:@"project"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://api.yysc.online/system/resetPassword" parameters:tempPar progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSDictionary *data = responseObject;
       NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
        if ([success isEqualToString:@"1"]) {
            [MBProgressHUD showMessage:@"重置成功"];
            //延时执行代码
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [MBProgressHUD hideHUD];
            [self dismissViewControllerAnimated:YES completion:nil];
                });
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"重置失败..."];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"重置失败"];
    }];
    
}




@end
