//
//  HNPNickNameVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/10.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPNickNameVC.h"

@interface HNPNickNameVC ()

@property (weak, nonatomic) IBOutlet UITextField *EditText_F;
@property (weak, nonatomic) IBOutlet UIButton *quedingBtn;

@end

@implementation HNPNickNameVC

- (void)awakeFromNib{
    [super awakeFromNib];
    [self textFMonitor];
}

- (void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    frame.size.height = [UIScreen mainScreen].bounds.size.height;
    [super setFrame:frame];
}

//取消按钮
- (IBAction)quxiaoBtn:(UIButton *)sender {
    [self removeFromSuperview];
}

//确定按钮
- (IBAction)quedingBtn:(id)sender {
    [MBProgressHUD showMessage:@"修改成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        if ([self.delegate respondsToSelector:@selector(EditSureBtnDidClick:)]) {
            [self.delegate EditSureBtnDidClick:self.EditText_F.text];
        }else{
            
        }
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        AFJSONResponseSerializer *response   = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        response.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"text/css",@"text/javascript", nil];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Referer"];
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 20.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        manager.responseSerializer = response;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSDictionary *tempdict = @{
            @"id" : appDelegate.mineUserInfoModel.userId,
            @"nickName" : self.EditText_F.text
        };
        [manager PUT:@"http://api.yysc.online/user/personal/updateUser" parameters:tempdict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"success"] isEqualToNumber:@1]) {
                NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
                NSMutableDictionary *userPlist = [[[NSMutableDictionary alloc] initWithContentsOfFile:path] mutableCopy];
                [userPlist setObject:self.EditText_F.text forKey:@"nickName"];
                [userPlist writeToFile:path atomically:YES];
                appDelegate.mineUserInfoModel.nickName = self.EditText_F.text;
            }
            else {
                [MBProgressHUD showError:@"修改失败" toView:self.superview];
                [self removeFromSuperview];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"网络错误"];
            NSLog(@"%@",error);
        }];
        [self removeFromSuperview];
    });
}

/**为输入框添加监听*/
-(void)textFMonitor{
    [self.EditText_F addTarget:self action:@selector(quedingBtnIsClickEnable) forControlEvents:UIControlEventEditingChanged];
}

-(void)quedingBtnIsClickEnable{
    if (self.EditText_F.text.length >= 1 && self.EditText_F.text.length <= 10) {
        self.quedingBtn.enabled = YES;
    }else{
        self.quedingBtn.enabled = NO;
    }
}
//点击屏幕其它地方关闭键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.EditText_F endEditing:YES];
}


@end
