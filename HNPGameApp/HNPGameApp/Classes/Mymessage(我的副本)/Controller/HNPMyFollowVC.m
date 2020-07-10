//
//  HNPMyFollowVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMyFollowVC.h"
#import "HNPMyFollowCell.h"

@interface HNPMyFollowVC ()<UITableViewDelegate,UITableViewDataSource,HNPQXFollowBtnDelegate>

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation HNPMyFollowVC

static NSString *IDOne = @"myFollowCellID";

- (void)viewWillAppear:(BOOL)animated{
    [self setNavigation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeView)];
    [self.view addGestureRecognizer:swipe];
}


#pragma mark - 方法调用

-(void)swipeView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setNavigation{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"我的关注";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"dingbu"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)loadTableView{
    //tableView的显示范围
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableview];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPMyFollowCell class]) bundle:nil] forCellReuseIdentifier:IDOne];
}


#pragma mark - tableView协议



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HNPMyFollowCell *myFollowCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
    myFollowCell.delegate = self;
    return myFollowCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - 自定义协议及数据加载

//点击取消关注按钮操作
- (void)MyQxFollowBtnDidClick:(HNPMyFollowCell *)myFollowCell{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定不再关注？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"点击了确定");
    }]];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}



@end
