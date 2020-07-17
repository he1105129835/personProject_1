//
//  HNPFabuYuezhanVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/4.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPFabuYuezhanVC.h"
#import "HNPTeamOneVC.h"
#import "HNPTeamTwoVC.h"
#import "HNPBattleTeamModel.h"
#import "HNPBattleTeamModelArray.h"

@interface HNPFabuYuezhanVC ()<HNPTeamOneVCReturnClickDelegate,HNPTeamTwoVCReturnClickDelegate>

//选择游戏标识
{
    int TeamTag;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *boxBtn_1;
@property (weak, nonatomic) IBOutlet UIButton *boxBtn_2;
@property (weak, nonatomic) IBOutlet UIButton *boxBtn_3;
@property (weak, nonatomic) IBOutlet UIButton *preSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *preSelectBtn_1;
@property (weak, nonatomic) IBOutlet UIImageView *touxiang_1;
@property (weak, nonatomic) IBOutlet UIImageView *touxiang_2;
@property (weak, nonatomic) IBOutlet UIImageView *touxiang_3;
@property (weak, nonatomic) IBOutlet UILabel *teamLable_1;
@property (weak, nonatomic) IBOutlet UILabel *teamLable_2;
@property (weak, nonatomic) IBOutlet UILabel *teamLable_3;
@property (weak, nonatomic) IBOutlet UIImageView *tianjia_1;
@property (weak, nonatomic) IBOutlet UIImageView *tianjia_2;
@property (weak, nonatomic) IBOutlet UIImageView *tianjia_3;
@property (weak, nonatomic) IBOutlet UIButton *fabuBtn;
@property (weak, nonatomic) IBOutlet UITextField *guizeText_f;
@property (weak, nonatomic) IBOutlet UITextField *phoneText_f;
@property (weak, nonatomic) IBOutlet UITextField *emailText_f;
@property (weak, nonatomic) IBOutlet UITextField *messageText_f;
@property (weak, nonatomic) IBOutlet UITextField *dataText_F;
@property (weak, nonatomic) IBOutlet UILabel *VsLable;

@property(nonatomic,strong)HNPPersonModel *mineUserInfoModel;
@property(nonatomic,strong)HNPBattleTeamModel *myBattleM;
@property(nonatomic,strong)NSString *modelName_1;
@property(nonatomic,strong)NSString *modelName_2;

@end

@implementation HNPFabuYuezhanVC

BOOL flag = 0;

- (void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"发布约战";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self kongjianHidden];
    [self lijifabuBtn];
    [self textFMonitor];
}

//控件隐藏
-(void)kongjianHidden{
    self.imageViewHeight.constant = 0;
    self.boxBtn_1.hidden = YES;
    self.boxBtn_2.hidden = YES;
    self.boxBtn_3.hidden = YES;
    self.touxiang_1.hidden = YES;
    self.touxiang_2.hidden = YES;
    self.touxiang_3.hidden = YES;
    self.teamLable_1.hidden = YES;
    self.teamLable_2.hidden = YES;
    self.teamLable_3.hidden = YES;
    self.tianjia_1.hidden = YES;
    self.tianjia_2.hidden = YES;
    self.tianjia_3.hidden = YES;
    self.VsLable.hidden = YES;
    self.preSelectBtn.backgroundColor = UIColor.systemBlueColor;
    self.preSelectBtn_1.backgroundColor = UIColor.systemBlueColor;
}

//切换按钮状态
- (IBAction)menuClick:(UIButton *)btn {
    self.touxiang_1.image = [UIImage imageNamed:@"pic_touxiangkuang1"];
    self.teamLable_1.text = nil;
    self.touxiang_3.image = [UIImage imageNamed:@"pic_touxiangkuang1"];
    self.teamLable_3.text = nil;
    self.preSelectBtn.selected = NO;
    self.preSelectBtn.backgroundColor = UIColor.clearColor;
    [btn setBackgroundColor:[UIColor systemBlueColor]];
    btn.selected = YES;
    self.preSelectBtn = btn;
    if (btn.tag == 101) {
        TeamTag = 0;
    }else if(btn.tag == 102){
        TeamTag = 1;
    }else if (btn.tag == 103){
        TeamTag = 2;
    }else{
        TeamTag = 3;
    }
}
- (IBAction)saizhiBtn:(UIButton *)btn {
    self.preSelectBtn_1.selected = NO;
    self.preSelectBtn_1.backgroundColor = UIColor.systemGray6Color;
    [btn setBackgroundColor:[UIColor systemBlueColor]];
    btn.selected = YES;
    self.preSelectBtn_1 = btn;
}


#pragma mark - 方法

//点击屏幕其它地方关闭键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//点击添加战队按钮进行控件的显示与隐藏
- (IBAction)addTeamBtn:(id)sender {
    if (flag == 0) {
        self.imageViewHeight.constant = 130;
        self.boxBtn_1.hidden = NO;
        self.boxBtn_2.hidden = NO;
        self.boxBtn_3.hidden = NO;
        self.touxiang_1.hidden = NO;
        self.touxiang_2.hidden = NO;
        self.touxiang_3.hidden = NO;
        self.teamLable_1.hidden = NO;
        self.teamLable_2.hidden = NO;
        self.teamLable_3.hidden = NO;
        self.tianjia_1.hidden = NO;
        self.tianjia_2.hidden = NO;
        self.tianjia_3.hidden = NO;
        self.VsLable.hidden = NO;
        flag = 1;
    }
    else {
        self.imageViewHeight.constant = 0;
        self.boxBtn_1.hidden = YES;
        self.boxBtn_2.hidden = YES;
        self.boxBtn_3.hidden = YES;
        self.touxiang_1.hidden = YES;
        self.touxiang_2.hidden = YES;
        self.touxiang_3.hidden = YES;
        self.teamLable_1.hidden = YES;
        self.teamLable_2.hidden = YES;
        self.teamLable_3.hidden = YES;
        self.tianjia_1.hidden = YES;
        self.tianjia_2.hidden = YES;
        self.tianjia_3.hidden = YES;
        self.VsLable.hidden = YES;
        flag = 0;
    }
    
}

/**为输入框添加监听*/
-(void)textFMonitor{
    [self.guizeText_f addTarget:self action:@selector(lijifabuBtn) forControlEvents:UIControlEventEditingChanged];
    [self.phoneText_f addTarget:self action:@selector(lijifabuBtn) forControlEvents:UIControlEventEditingChanged];
    [self.emailText_f addTarget:self action:@selector(lijifabuBtn) forControlEvents:UIControlEventEditingChanged];
    [self.messageText_f addTarget:self action:@selector(lijifabuBtn) forControlEvents:UIControlEventEditingChanged];
}
//立即发布按钮能否点击判断
-(void)lijifabuBtn{
    if (self.guizeText_f.text.length >= 0 && self.phoneText_f.text.length >= 0 && self.emailText_f.text.length >= 0 &&self.messageText_f.text.length >= 0) {
        self.fabuBtn.enabled = YES;
    }else{
        self.fabuBtn.enabled = NO;
    }
}

//战队头像按钮
- (IBAction)yuezhan_1Btn:(id)sender {
    HNPTeamOneVC *teamOne = [HNPTeamOneVC new];
    teamOne.TeamTag = TeamTag;
    teamOne.delegate = self;
    [self presentViewController:teamOne animated:YES completion:nil];
}
- (IBAction)yuezhan_2Btn:(id)sender {
    HNPTeamTwoVC *teamTwo = [HNPTeamTwoVC new];
    teamTwo.TeamTag = TeamTag;
    teamTwo.delegate = self;
    [self presentViewController:teamTwo animated:YES completion:nil];
}

//切换战队代理
- (void)returnDataOneWhenClick:(HNPTeamOneVC *)OneVC returnClick:(HNPPaimingListModel *)Model{
    self.touxiang_1.image = [UIImage imageNamed:Model.iconName];
    self.modelName_1 = Model.iconName;
    self.teamLable_1.text = Model.teamName;
}
- (void)returnDataTwoWhenClick:(HNPTeamTwoVC *)OneVC returnClick:(HNPPaimingListModel *)Model{
    self.touxiang_3.image = [UIImage imageNamed:Model.iconName];
    self.modelName_2 = Model.iconName;
    self.teamLable_3.text = Model.teamName;
}

- (IBAction)fabuBtnClick:(UIButton *)sender {
    [self WhetherToLoginOrNot];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.login == YES) {
        if (self.dataText_F.text.length != 0) {
            [MBProgressHUD showMessage:@"发布成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                
                NSDateFormatter *formatter = [NSDateFormatter new];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *dataNow = [NSDate date];
                NSString *currentTimeString = [formatter stringFromDate:dataNow];
                HNPBattleTeamModel *myBattleM = [HNPBattleTeamModel new];
                myBattleM.battleTeamHead_1 = self.modelName_1;
                myBattleM.battleTeamName_1 = self.teamLable_1.text;
                myBattleM.battleTeamHead_2 = self.modelName_2;
                myBattleM.battleTeamName_2 = self.teamLable_3.text;
                myBattleM.fabuTime = currentTimeString;
                myBattleM.gameName = currentTimeString;
                
                NSString *filePath1 = [NSTemporaryDirectory() stringByAppendingPathComponent:@"battleTeam.data"];
                NSLog(@"%@",NSTemporaryDirectory());
                //解档
                HNPBattleTeamModelArray *tempArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath1];
                if (tempArray.modelArray == nil) {
                    tempArray = [HNPBattleTeamModelArray new];
                    tempArray.modelArray = [NSMutableArray new];
                }
                [tempArray.modelArray addObject:myBattleM];
                NSString *temp = NSTemporaryDirectory();
                NSString *filePath = [temp stringByAppendingPathComponent:@"battleTeam.data"];
                //归档
                [NSKeyedArchiver archiveRootObject:tempArray toFile:filePath];
            });
        }else{
            [MBProgressHUD showError:@"请选择发布时间"];
        }
        
        
    }else{
        HNPLoginVC *loginVC = [HNPLoginVC new];
        loginVC.loginType = NO;
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}

#pragma mark - 判断是否登录

-(void)WhetherToLoginOrNot{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
    self.mineUserInfoModel = [HNPPersonModel mj_objectWithFile:path];
    if (self.mineUserInfoModel == nil) {
        appDelegate.login = NO;
    }else{
        appDelegate.login = YES;
    }
}



@end
