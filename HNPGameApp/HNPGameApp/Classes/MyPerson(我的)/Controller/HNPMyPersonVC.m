//
//  HNPMyPersonVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/6/29.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMyPersonVC.h"
#import "HNPMyPersonheaderCell.h"
#import "HNPMyCollectionVC.h"
#import "HNPMyZanVC.h"
#import "HNPMyFollowVC.h"
#import "HNPMyBattleVC.h"
#import "HNPLoginVC.h"
#import "HNPEditVC.h"
#import "HNPMyPersonheaderCell.h"
#import "HNPDianJingModel.h"
#import "HNPResetPasswordVC.h"


@interface HNPMyPersonVC ()<UITableViewDelegate,UITableViewDataSource,HNPMyPersonBtnDelegate>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)HNPPersonModel *mineUserInfoModel;

@end

@implementation HNPMyPersonVC

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    self.title = @"我的";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"editHeader" object:nil];
}

static NSString *IDOne = @"myPensonHeaderCellID";
static NSString *IDTwo = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
}



//加载数据
-(HNPPersonModel *)mineUserInfoModel{
    if (_mineUserInfoModel == nil) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _mineUserInfoModel = appDelegate.mineUserInfoModel;
    }
    return _mineUserInfoModel;
}

-(void)loadTableView{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - ([UIApplication sharedApplication].statusBarFrame.size.height)) style:UITableViewStylePlain];
          [self.view addSubview:_tableview];
          _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.bounces = NO;
          _tableview.dataSource = self;
          _tableview.delegate = self;
    _tableview.contentInset = UIEdgeInsetsMake(-[UIApplication sharedApplication].statusBarFrame.size.height, 0, 0, 0);
       [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPMyPersonheaderCell class]) bundle:nil] forCellReuseIdentifier:IDOne];
}


#pragma mark - 协议方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 8;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HNPMyPersonheaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
        headerCell.delegate = self;
        headerCell.personMdoel = self.mineUserInfoModel;
        return headerCell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDTwo];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDTwo];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"ic_guanyu"];
                cell.textLabel.text = @"关于我们";
            }else if (indexPath.row == 1){
                cell.imageView.image = [UIImage imageNamed:@"ic_fankui"];
                cell.textLabel.text = @"反馈中心";
            }else if (indexPath.row == 2){
                cell.imageView.image = [UIImage imageNamed:@"ic_bianji"];
                cell.textLabel.text = @"编辑资料";
            }else if (indexPath.row == 3){
                cell.imageView.image = [UIImage imageNamed:@"ic_xiugai"];
                cell.textLabel.text = @"修改密码";
            }else if (indexPath.row == 4){
                cell.imageView.image = [UIImage imageNamed:@"ic_qiehuan"];
                cell.textLabel.text = @"切换账号";
            }else if (indexPath.row == 5){
                cell.imageView.image = [UIImage imageNamed:@"ic_tuichu"];
                cell.textLabel.text = @"退出登录";
            }else if (indexPath.row == 6){
                cell.imageView.image = [UIImage imageNamed:@"ic_xieyi"];
                cell.textLabel.text = @"用户协议";
            }else if (indexPath.row == 7){
                cell.imageView.image = [UIImage imageNamed:@"ic_yinsizhengce"];
                cell.textLabel.text = @"隐私政策";
            }
        }
         return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        
    }else{
        if (indexPath.row == 0) {
//            NSLog(@"点击了第1行");
        }else if (indexPath.row == 1){
//            NSLog(@"点击了第2行");
        }else if (indexPath.row == 2){
            //点击跳转编辑资料控制器
            HNPEditVC *editVC = [HNPEditVC new];
            self.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:editVC animated:YES];
        }else if (indexPath.row == 3){
            HNPResetPasswordVC *resetVC = [HNPResetPasswordVC new];
            [self presentViewController:resetVC animated:YES completion:nil];
        }else if (indexPath.row == 4){
//            NSLog(@"点击了第5行");
        }else if (indexPath.row == 5){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定退出登录？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSError *error;
                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
                if ([fileManager removeItemAtPath:path error:&error]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"zhuxiao" object:self];
                }else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"zhuxiao" object:self];
                }
            }]];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else if (indexPath.row == 6){
//            NSLog(@"点击了第7行");
        }else if (indexPath.row == 7){
//            NSLog(@"点击了第8行");
        }
    }
}


//自定义协议跳转4个不同的控制器
- (void)collectionBtnDidClick:(HNPMyPersonheaderCell *)headerCell{
    HNPMyCollectionVC *collectionVC = [HNPMyCollectionVC new];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:collectionVC animated:YES];
}
- (void)zanBtnDidClick:(HNPMyPersonheaderCell *)headerCell{
    HNPMyZanVC *zanVC = [HNPMyZanVC new];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:zanVC animated:YES];
}
- (void)followBtnDidClick:(HNPMyPersonheaderCell *)headerCell{
    HNPMyFollowVC *followVC = [HNPMyFollowVC new];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:followVC animated:YES];
}
- (void)battleBtnDidClick:(HNPMyPersonheaderCell *)headerCell{
    HNPMyBattleVC *battleVC = [HNPMyBattleVC new];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:battleVC animated:YES];
}




@end
