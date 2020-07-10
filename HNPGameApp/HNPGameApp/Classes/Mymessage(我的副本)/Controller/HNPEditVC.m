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

@interface HNPEditVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,selectPhotoDelegate>
@property (weak, nonatomic) IBOutlet UIButton *changeHeadBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headPicture;
@property (nonatomic,strong)SelectPhotoManager *photoManger;
@property(nonatomic,strong)HNPPersonModel *mineUserInfoModel;


@end

@implementation HNPEditVC

- (void)viewWillAppear:(BOOL)animated{
    [self setNavigation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setphotoImage];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeView)];
    [self.view addGestureRecognizer:swipe];
}


#pragma mark - 方法调用

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
    UIImage *img = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults]objectForKey:@"photoView"]];
    if (img) {
        self.headPicture.image = img;
    }
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
                [MBProgressHUD showMessage:@"正在修改..."];
                       NSDictionary *dict = @{
                               @"file" : image
                           };
                           [NetworkTool.shared postReturnString:@"http://image.yysc.online/upload" fileName:@"headerImage" image:image viewcontroller:nil params:dict  success:^(id _Nonnull response) {
                               AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                               manager.requestSerializer = [AFJSONRequestSerializer serializer];
                               AFJSONResponseSerializer *response_Manager = [AFJSONResponseSerializer serializer];
                               response_Manager.removesKeysWithNullValues = YES;
                               response_Manager.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"text/css",@"text/javascript", nil];
                               manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
                               [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                               [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Referer"];
                               // 设置超时时间
                               [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
                               manager.requestSerializer.timeoutInterval = 20.f;
                               [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
                               manager.responseSerializer = response_Manager;
                               AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                               NSDictionary *tempdict = @{
                                   @"id" : appDelegate.mineUserInfoModel.userId,
                                   @"head" : response,
                               };
                               [manager PUT:@"http://api.yysc.online/user/personal/updateUser" parameters:tempdict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                   [MBProgressHUD hideHUD];
                                   if ([responseObject[@"success"] isEqualToNumber:@1]) {
                                       NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
                                       NSMutableDictionary *userPlist = [[[NSMutableDictionary alloc] initWithContentsOfFile:path] mutableCopy];
                                       [userPlist setObject:response forKey:@"head"];
                                       [userPlist writeToFile:path atomically:YES];
                                       weakSelf.mineUserInfoModel.head = response;
                                       [MBProgressHUD showSuccess:@"修改成功"];
                                       [weakSelf userEdit];
                                   }
                                   else {
                                       [MBProgressHUD showError:@"修改失败"];
                                   }
                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   [MBProgressHUD hideHUD];
                                   [MBProgressHUD showError:@"网络错误"];
                                   NSLog(@"%@",error);
                               }];
                           } failture:^(NSError * _Nonnull error) {
                       //        [Toast makeText:weakSelf.view Message:@"上传图片失败" afterHideTime:DELAYTiME];
                               [MBProgressHUD hideHUD];
                                [MBProgressHUD showError:@"上传图片失败"];
                           }];
                   };
        
           };


#pragma mark - 数据上传

- (void)userEdit
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.mineUserInfoModel = appDelegate.mineUserInfoModel;
}



@end
