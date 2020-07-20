//
//  HNPMyZanVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMyZanVC.h"
#import "HNPMyZanCell.h"
#import "HNPZanGdModelArray.h"

@interface HNPMyZanVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)HNPPersonModel *mineUserInfoModel;
@property (strong, nonatomic)HNPZanGdModelArray *tempZanGdArray;

@end

@implementation HNPMyZanVC

static NSString *IDOne = @"MyZanCellID";

- (void)viewWillAppear:(BOOL)animated{
    [self setNavigation];
    if (self.tempZanGdArray.zanGdArray.count == 0) {
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

#pragma mark - 解档
-(HNPZanGdModelArray *)tempZanGdArray{
    if (_tempZanGdArray == nil) {
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"myZan.data"];
        if (filePath == nil) {
                       
                   } else {
                       _tempZanGdArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
                   }
    }
    return _tempZanGdArray;
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
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"我的点赞";
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
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPMyZanCell class]) bundle:nil] forCellReuseIdentifier:IDOne];
}


#pragma mark - tableView协议

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tempZanGdArray.zanGdArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HNPMyZanCell *myZanCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
    myZanCell.ZanGdM = self.tempZanGdArray.zanGdArray[indexPath.row];
    return myZanCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - 自定义协议及数据加载

@end
