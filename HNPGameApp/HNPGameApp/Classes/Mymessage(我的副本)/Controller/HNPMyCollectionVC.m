//
//  HNPMyCollectionVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMyCollectionVC.h"
#import "HNPMyCollectionCell.h"

@interface HNPMyCollectionVC ()<UITableViewDelegate,UITableViewDataSource,HNPQXCollectionBtnDelegate>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)HNPPersonModel *mineUserInfoModel;
@property(nonatomic,strong)NSArray *DJArray;

@end

@implementation HNPMyCollectionVC

static NSString *IDOne = @"myCollectionCellID";

- (void)viewWillAppear:(BOOL)animated{
    [self setNavigation];
    if (self.DJArray.count == 0) {
        self.tableview.backgroundColor = UIColor.clearColor;
    }else{
        self.tableview.backgroundColor = UIColor.whiteColor;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
}

-(NSArray *)DJArray{
    
//        if (!_DJArray) {
            _DJArray = [HNPDianJingModel mj_objectArrayWithFilename:@"DJClub.plist"];
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSArray *dataArray = [userDefault objectForKey:@"userCollectArray"];
            NSMutableArray *temp = [NSMutableArray array];
            for (int i = 0; i < dataArray.count; i++) {
                NSDictionary *ID = dataArray[i];
                for (int i = 0; i < _DJArray.count; i++) {
                    HNPDianJingModel *djModelArrayID = _DJArray[i];
                    if ([ID[@"userid"] isEqualToString:djModelArrayID.userid]) {
                        djModelArrayID.isCollect = YES;
                        [temp addObject:djModelArrayID];
                    }
                }
            }
            _DJArray = temp;
            
//        }
        return _DJArray;
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
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 10, 15)];
    [backButton setBackgroundImage:[[UIImage imageNamed:@"btn_fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = item;
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"我的收藏";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"dingbu"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadTableView{
    //tableView的显示范围
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - ([UIApplication sharedApplication].statusBarFrame.size.height) - 44) style:UITableViewStylePlain];
    [self.view addSubview:_tableview];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPMyCollectionCell class]) bundle:nil] forCellReuseIdentifier:IDOne];
    _tableview.estimatedRowHeight = 100;
    _tableview.rowHeight = UITableViewAutomaticDimension;
}


#pragma mark - tableView协议

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DJArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HNPMyCollectionCell *collectionCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
    collectionCell.delegate = self;
    collectionCell.djModel = self.DJArray[indexPath.row];
    return collectionCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - 自定义协议及数据加载
- (void)MyQxCollectionBtnDidClick:(HNPMyCollectionCell *)myCollectionCell{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要取消收藏吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"点击了确定");
        
        // 获取当前点击行数
        NSIndexPath *indexPath = [self.tableview indexPathForCell:myCollectionCell];
        // 收藏状态更新
        myCollectionCell.djModel.isCollect = !myCollectionCell.djModel.isCollect;
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        // 取出本地收藏数据
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *dataList = [[NSMutableDictionary alloc] init];
        NSArray *temp =[userDefault objectForKey:@"userCollectArray"];
        NSMutableArray *dataArray = [NSMutableArray array];
        for (int i = 0; i < temp.count; i++)
        {
            [dataArray addObject:temp[i]];
        }
        // 收藏
        if (myCollectionCell.djModel.isCollect == YES) {
            // 添加id值和收藏状态
            [dataList setObject:myCollectionCell.djModel.userid forKey:@"userid"];
            [dataList setObject:[NSNumber numberWithBool:myCollectionCell.djModel.isCollect] forKey:@"isCollect"];
            [dataArray addObject:dataList];
            // 保存
            [userDefault setObject:dataArray forKey:@"userCollectArray"];
            [userDefault synchronize];
            
        }
        // 取消收藏
        else {
            // 判断id值删除对应的收藏
            for (int i = 0; i < dataArray.count; i++) {
                NSDictionary *ID = dataArray[i];
                if ([ID[@"userid"] isEqualToString:myCollectionCell.djModel.userid]) {
                    NSLog(@"%d",i);
                    [dataArray removeObjectAtIndex:i];
                }
            }
            // 保存
            [userDefault setObject:dataArray forKey:@"userCollectArray"];
            [userDefault synchronize];
        }
        [self DJArray];
        if (self.DJArray.count == 0) {
            self.tableview.backgroundColor = UIColor.clearColor;
        }else{
            self.tableview.backgroundColor = UIColor.whiteColor;
        }
        [self.tableview reloadData];
        
        
        
    }]];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}



@end
