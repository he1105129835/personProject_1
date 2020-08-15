//
//  HNPSendCodeVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/7.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPSendCodeVC.h"

@interface HNPSendCodeVC ()
@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;
@property (weak, nonatomic) IBOutlet UIImageView *YZMImageView;
@property (weak, nonatomic) IBOutlet UITextField *text_F;

@end

@implementation HNPSendCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加点击方法
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imagerefresh)];
    self.YZMImageView.userInteractionEnabled = YES;
    [self.YZMImageView addGestureRecognizer:tap];
    self.view.backgroundColor = UIColor.clearColor;
}




#pragma mark - 方法调用

- (IBAction)gaunbi:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//刷新验证码
-(void)imagerefresh{
    NSURL *url = [NSURL URLWithString:@"http://api.yysc.online/system/sendVerify"];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSString *imageS = [NSString stringWithFormat:@"%@",dict[@"data"]];
         NSData *ImageData =[[NSData alloc]initWithBase64EncodedString:imageS options:NSDataBase64DecodingIgnoreUnknownCharacters];
       UIImage *testImage = [UIImage imageWithData:ImageData];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.YZMImageView.image = testImage;
        }];
    }]resume];
}

//发送验证码
- (IBAction)DoneBtnClick:(id)sender {
    //根据type值判断进行注册或者重置密码
    
    //进行注册
    if (self.type == 0) {
        NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
        [par setObject:self.phone forKey:@"phone"];
        [par setObject:@"1" forKey:@"type"];
        [par setObject:@"game" forKey:@"project"];
        [par setObject:self.text_F.text forKey:@"code"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
           [manager POST:@"http://api.yysc.online/system/sendCode" parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   
               NSDictionary *data = responseObject;
               NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
               NSLog(@"%@",data);
               if ([success isEqualToString:@"1"]) {
                   [MBProgressHUD showMessage:@"获取验证码成功..."];
                   
                   //延时执行代码
                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUD];
                       [self dismissViewControllerAnimated:YES completion:nil];
                           
                       });
               }else{
                   [MBProgressHUD hideHUD];
                   [MBProgressHUD showError:@"验证失败，手机号或验证码不正确。"];
               }
               
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"failure");
               }];
        
        //进行重置
    }else if(self.type == 1){
        NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
        [par setObject:self.phone forKey:@"phone"];
        [par setObject:@"3" forKey:@"type"];
        [par setObject:@"game" forKey:@"project"];
        [par setObject:self.text_F.text forKey:@"code"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
           [manager POST:@"http://api.yysc.online/system/sendCode" parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   
               NSDictionary *data = responseObject;
               NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
               NSLog(@"%@",data);
               if ([success isEqualToString:@"1"]) {
                   [MBProgressHUD showMessage:@"获取验证码成功..."];
                   
                   //延时执行代码
                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUD];
                       [self dismissViewControllerAnimated:YES completion:nil];
                           
                       });
               }else{
                   [MBProgressHUD hideHUD];
                   [MBProgressHUD showError:@"验证失败，手机号或验证码不正确。"];
               }
               
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"failure");
               }];
    }
    
}

//点击屏幕其它地方关闭键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - 数据

@end
