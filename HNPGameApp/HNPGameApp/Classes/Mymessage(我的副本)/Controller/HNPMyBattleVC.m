//
//  HNPMyBattleVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMyBattleVC.h"
#import "HNPMyBattleCell.h"
#import "HNPBattleTeamModelArray.h"

@interface HNPMyBattleVC ()<UITableViewDelegate,UITableViewDataSource,HNPDeleteBtnDelegate>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)HNPPersonModel *mineUserInfoModel;
@property (strong, nonatomic)HNPBattleTeamModelArray *teamArray;

@end

@implementation HNPMyBattleVC

static NSString *IDOne = @"myBattleCellID";

- (void)viewWillAppear:(BOOL)animated{
    [self setNavigation];
    if (self.teamArray.modelArray.count == 0) {
        self.tableview.backgroundColor = UIColor.clearColor;
    }else{
        self.tableview.backgroundColor = UIColor.whiteColor;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeView)];
    [self.view addGestureRecognizer:swipe];
    
}

-(HNPBattleTeamModelArray *)teamArray{
    if (_teamArray == nil) {
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"battleTeam.data"];
        if (filePath == nil) {
                       
                   } else {
                       _teamArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
                   }
    }
    return _teamArray;
}

//加载数据
-(HNPPersonModel *)mineUserInfoModel{
    if (_mineUserInfoModel == nil) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _mineUserInfoModel = appDelegate.mineUserInfoModel;
    }
    return _mineUserInfoModel;
}

#pragma mark - 方法调用

-(void)swipeView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setNavigation{
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"我的约战";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"dingbu"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)loadTableView{
    //tableView的显示范围
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - ([UIApplication sharedApplication].statusBarFrame.size.height) - 44) style:UITableViewStylePlain];
    [self.view addSubview:_tableview];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPMyBattleCell class]) bundle:nil] forCellReuseIdentifier:IDOne];
}


#pragma mark - tableView协议

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.teamArray.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HNPMyBattleCell *myBattleCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
    myBattleCell.battleTeamM = self.teamArray.modelArray[indexPath.row];
    myBattleCell.delegate = self;
    return myBattleCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [_tableview deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - 自定义协议及数据加载

- (void)MyBattleDeleteBtnDidClick:(HNPMyBattleCell *)myBattleDeleteCell{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定取消本场比赛？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self teamArray];
        NSIndexPath *cellIndexPath = [self.tableview indexPathForCell:myBattleDeleteCell];
        [self.teamArray.modelArray removeObjectAtIndex:cellIndexPath.row];
        [self.tableview deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        //归档
        
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"battleTeam.data"];
        [NSKeyedArchiver archiveRootObject:self.teamArray toFile:filePath];
        if (self.teamArray.modelArray.count == 0) {
            self.tableview.backgroundColor = UIColor.clearColor;
        }else{
            self.tableview.backgroundColor = UIColor.whiteColor;
        }
        
    }]];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}





@end
