//
//  HNPEditVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/9.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPEditVC.h"
#import "SelectPhotoManager.h"
#import "AppDelegate.h"
#import "HNPEditNickNameView.h"
#import "HNPNickNameVC.h"
#import "HNPMySetTextField.h"

@interface HNPEditVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,selectPhotoDelegate,HNPquedingBtnDelegate,HNPEditNickNameDelegate>
@property (weak, nonatomic) IBOutlet UIButton *changeHeadBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headPicture;
@property (nonatomic,strong)SelectPhotoManager *photoManger;
@property(nonatomic,strong)HNPPersonModel *mineUserInfoModel;
@property(nonatomic,copy)NSString *saveURL;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLbale;
@property (weak, nonatomic) IBOutlet UILabel *xingbieLable;
@property (weak, nonatomic) IBOutlet UITextField *MyInfoText_F;
@property (weak, nonatomic) IBOutlet HNPMySetTextField *shengriText_F;

@end

@implementation HNPEditVC

- (void)viewWillAppear:(BOOL)animated{
    [self WhetherToLoginOrNot];
    [self setNavigation];
//    [self mineUserInfoModel];
    [self.headPicture sd_setImageWithURL:[NSURL URLWithString:self.mineUserInfoModel.head] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    self.nickNameLbale.text = self.mineUserInfoModel.nickName;
    self.xingbieLable.text = self.mineUserInfoModel.sex;
    self.MyInfoText_F.text = self.mineUserInfoModel.signature;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setphotoImage];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeView)];
    [self.view addGestureRecognizer:swipe];
    self.MyInfoText_F.enabled = NO;
    self.shengriText_F.enabled = NO;
}


#pragma mark - 方法调用

//加载数据
-(HNPPersonModel *)mineUserInfoModel{
    if (_mineUserInfoModel == nil) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _mineUserInfoModel = appDelegate.mineUserInfoModel;
    }
    return _mineUserInfoModel;
}

//点击屏幕任意地方收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.MyInfoText_F endEditing:YES];
    [self.shengriText_F endEditing:YES];
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
        @"nickName" : self.MyInfoText_F.text
    };
    [manager PUT:@"http://api.yysc.online/user/personal/updateUser" parameters:tempdict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"success"] isEqualToNumber:@1]) {
            NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
            NSMutableDictionary *userPlist = [[[NSMutableDictionary alloc] initWithContentsOfFile:path] mutableCopy];
            [userPlist setObject:self.MyInfoText_F.text forKey:@"nickName"];
            [userPlist writeToFile:path atomically:YES];
            appDelegate.mineUserInfoModel.signature = self.MyInfoText_F.text;
        }
        else {
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
//轻扫返回
-(void)swipeView{
    [self.navigationController popViewControllerAnimated:YES];
}
//设置导航栏
-(void)setNavigation{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"编辑资料";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"dingbu"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

//添加相机的点击手势
- (void)setphotoImage{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoClick:)];
    [self.changeHeadBtn addGestureRecognizer:tap];
//    UIImage *img = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults]objectForKey:@"photoView"]];
//    if (img) {
//        self.headPicture.image = img;
//    }
}
//相册的图片选择
- (void)photoClick:(UITapGestureRecognizer *)recognizer{
   if (!_photoManger) {
       _photoManger = [[SelectPhotoManager alloc]init];
       _photoManger.delegate = self;
   }
    __weak __typeof(self) weakSelf = self;
    [self.photoManger startSelectPhotoWithImageName:@"选择头像"];
    self.photoManger.successHandle = ^(SelectPhotoManager *manager, UIImage *image) {
        //上传数据
               weakSelf.headPicture.image = image;
                       NSDictionary *dict = @{
                               @"file" : image
                           };
        [NetworkTool.shared postReturnString:@"http://image.yysc.online/upload" fileName:@"testImage" image:image viewcontroller:nil params:dict success:^(id _Nonnull resopnse) {
            weakSelf.saveURL = resopnse;
            if (weakSelf.saveURL != nil) {
                [weakSelf userEdit];
            }else{
                NSLog(@"上传失败");
            }
    
        } failture:^(NSError * _Nonnull error) {
        
        }];
    };
};

#pragma mark - 数据上传

- (void)userEdit
{
//    __weak __typeof(self) weakSelf = self;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic = @{@"id" : appDelegate.mineUserInfoModel.userId,@"head" : self.saveURL};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager PUT:@"http://api.yysc.online/user/personal/updateUser" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"success"] isEqualToNumber:@1]) {
            NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
            NSMutableDictionary *userPlist = [[[NSMutableDictionary alloc] initWithContentsOfFile:path] mutableCopy];
            [userPlist setObject:self.saveURL forKey:@"head"];
            [userPlist setObject:self.nickNameLbale.text forKey:@"nickName"];
            [userPlist writeToFile:path atomically:YES];
            appDelegate.mineUserInfoModel.head = self.saveURL;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败");
    }];
}

#pragma mark - 按钮

//昵称修改
- (IBAction)nickName:(UIButton *)sender {
    HNPNickNameVC *nickNameView = [[[NSBundle mainBundle] loadNibNamed:@"HNPNickNameVC" owner:nil options:nil] firstObject];
    nickNameView.delegate = self;
    [self.navigationController.view addSubview:nickNameView];
}
//性别修改
- (IBAction)xingbie:(UIButton *)sender {
    HNPEditNickNameView *xingbieView = [[[NSBundle mainBundle] loadNibNamed:@"HNPEditNickNameView" owner:nil options:nil] firstObject];
    xingbieView.delegate = self;
    [self.navigationController.view addSubview:xingbieView];
}
//生日修改
- (IBAction)shengri:(UIButton *)sender {
}
//个性简介修改
- (IBAction)gexing:(UIButton *)sender {
}
//退出编辑
- (IBAction)tuichuEdit:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//性别修改协议
- (void)quedingBtnDidClick:(NSString *)setSex{
    self.xingbieLable.text = setSex;
}
//昵称修改协议
- (void)EditSureBtnDidClick:(NSString *)setNickName{
    self.nickNameLbale.text = setNickName;
}

-(void)WhetherToLoginOrNot{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
    self.mineUserInfoModel = [HNPPersonModel mj_objectWithFile:path];
    if (self.mineUserInfoModel == nil) {
        self.login = NO;
    }else{
        self.login = YES;
    }
}

@end
