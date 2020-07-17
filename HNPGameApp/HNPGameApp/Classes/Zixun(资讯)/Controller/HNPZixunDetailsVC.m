//
//  HNPZixunDetailsVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPZixunDetailsVC.h"
#import "HNPZixunDetailsCell.h"
#import "HNPZixunCommentCell.h"
#import "HNPCommentModel.h"
#import "HNPPersonModel.h"
#import "HNPLoginVC.h"
#import <Mantle.h>
#import "HNPZixunModel.h"

@interface HNPZixunDetailsVC ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *blackView;
@property (strong, nonatomic)NSArray *commentArray;
@property (weak, nonatomic) IBOutlet UITextField *commentText_F;
@property (nonatomic,strong)HNPPersonModel *mineUserInfoModel;

@end

@implementation HNPZixunDetailsVC

static NSString *IDOne = @"zixunDetailsCellID";
static NSString *IDTwo = @"zixunCommentCellID";

- (void)viewWillAppear:(BOOL)animated{
    [self setNavigation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    //轻扫返回手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeView)];
    [self.view addGestureRecognizer:swipe];
    [self setNotificationCenter];
    [self PLJson];
    
}

#pragma mark - 评论说说
- (IBAction)CommentBtnClick:(UIButton *)sender {
    //判断是否登录
    [self WhetherToLoginOrNot];
    if (self.login == YES) {
        [self Commentshuoshuo];
    }else{
        HNPLoginVC *loginVC = [HNPLoginVC new];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}


#pragma mark - 方法调用

-(void)Commentshuoshuo{
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
     
    [par setObject:self.mineUserInfoModel.userId forKey:@"userId"];
    [par setObject:self.zixunDetailsM.talkId forKey:@"talkId"];
    [par setObject:self.commentText_F.text forKey:@"content"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       
        [manager POST:@"http://api.yysc.online/user/talk/commentTalk" parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
            NSDictionary *data = responseObject;
    //        NSLog(@"%@",data);
            NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
            if ([success isEqualToString:@"1"]) {
                [MBProgressHUD showMessage:@"评论成功..."];
                
                //延时执行代码
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [MBProgressHUD hideHUD];
                [self.view endEditing:YES];
                    self.commentText_F.text = nil;
                    [self PLJson];
                    });
            }else{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"评论失败，重新输入"];
            }
            
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD showError:@"评论失败，重新输入"];
            }];
    
}

-(void)swipeView{
    [self.navigationController popViewControllerAnimated:YES];
}

//设置导航条
-(void)setNavigation{
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = @"评论";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"dingbu"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

#pragma mark - 加载tableView
-(void)loadTableView{
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPZixunDetailsCell class]) bundle:nil] forCellReuseIdentifier:IDOne];
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPZixunCommentCell class]) bundle:nil] forCellReuseIdentifier:IDTwo];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.commentArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HNPZixunDetailsCell *detailsCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
        detailsCell.DetailsModle = self.zixunDetailsM;
        if (self.zixunDetailsM.isFollow == NO) {
            detailsCell.followBtn.selected = NO;
        }else if(self.zixunDetailsM.isFollow == YES){
            detailsCell.followBtn.selected = YES;
        }
        return detailsCell;
    }else{
        HNPZixunCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:IDTwo];
        commentCell.UserModel = self.commentArray[indexPath.row];
        return commentCell;
    }
}

#pragma mark - 获取评论
- (void)PLJson
{
   NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.yysc.online"] sessionConfiguration:configuration];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        AFJSONResponseSerializer *response   = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        response.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"text/css",@"text/javascript", nil];
    //    manager.responseSerializer = response;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Referer"];
        // 设置超时时间
        
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 20.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
     
        //根据用户的talkId加载详情界面的评论
    [manager POST:@"/user/talk/getCommentList" parameters:@{@"_orderByDesc":@"publishTime",@"talkId": self.zixunDetailsM.talkId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable result) {
        self.commentArray = [HNPZixunModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
        [self.tableview reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        
}

#pragma mark - 表头设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 28)];
        view.backgroundColor = UIColor.whiteColor;
        UIView *view1 = [UIView new];
        view1.frame = CGRectMake(22.5, 7.5, 1.5, 15);
        view1.backgroundColor = [UIColor colorWithRed:73/255.0 green:167/255.0 blue:255/255.0 alpha:1.0];
        [view addSubview:view1];
        UILabel *lable = [UILabel new];
        lable.frame = CGRectMake(29, 7.5, 80, 14);
        lable.font = [UIFont systemFontOfSize:15];
        lable.text = @"全部评论";
        [view addSubview:lable];
        return view;;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 28;
    }
}

//键盘通知
-(void)setNotificationCenter{
    // 注册键盘弹起收回通知，使输入框位置于键盘上
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // tableView不会响应touchesBegan，单独添加手势响应
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)]; // 手势类型随你喜欢。
    tapGesture.delegate = self;
}

#pragma mark - 键盘弹出

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    //获取键盘弹出的时间
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //获取键盘上端Y坐标
    CGFloat keyboardY = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    //获取输入框下端相对于window的Y坐标
    CGRect rect = [self.blackView convertRect:self.blackView.bounds toView:[[[UIApplication sharedApplication] delegate] window]];
    CGPoint tmp = rect.origin;
    CGFloat inputBoxY = tmp.y + self.blackView.frame.size.height;
    //计算二者差值
    CGFloat ty = keyboardY - inputBoxY;
//    NSLog(@"position keyboard: %f, inputbox: %f, ty: %f", keyboardY, inputBoxY, ty);
    //差值小于0，做平移变换
    [UIView animateWithDuration:duration animations:^{
        if (ty < 0) {
            self.view.transform = CGAffineTransformMakeTranslation(0, ty);
        }
    }];

}

#pragma mark - 键盘消失
- (void)keyboardWillHide:(NSNotification *)notification
{
    //获取键盘弹出的时间
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //还原
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

#pragma mark - 点击屏幕其它地方关闭键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)tapGesturedDetected:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}

#pragma mark - 判断是否登录

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
