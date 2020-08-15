//
//  HNPWZController.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/1.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPWZController.h"
#import "HNPziXunCell.h"
#import "HNPZixunDetailsVC.h"

@interface HNPWZController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSDictionary *jsonDict;
@property(nonatomic,strong)NSArray *WZArray;
//页数
@property int moreDataFlag;

@end

@implementation HNPWZController

static NSString *IDOne = @"ziXunCellID";

- (void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    //每次加载2页
    [self WZJson:@2];
    self.moreDataFlag = 1;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self WZJson:@2];
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //上拉一次加载3页
        int flag = 2 + self.moreDataFlag * 3;
        [self WZJson:[NSNumber numberWithInt:flag]];
        self.moreDataFlag += 1;
        //下拉后再上拉则再原来的基础上再加3页
    }];
}

-(void)loadTableView{
    //tableView的显示范围
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - ([UIApplication sharedApplication].statusBarFrame.size.height + 99)) style:UITableViewStylePlain];
    [self.view addSubview:_tableview];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPziXunCell class]) bundle:nil] forCellReuseIdentifier:IDOne];
    _tableview.estimatedRowHeight = 100;
    _tableview.rowHeight = UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.WZArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HNPziXunCell *ziXunCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
    ziXunCell.zixunMdoel = self.WZArray[indexPath.row];
    ziXunCell.zixunFabuNameLable.text = @"·王者荣耀·";
    return ziXunCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview deselectRowAtIndexPath:indexPath animated:NO];
    HNPZixunDetailsVC *zixunDetailsVC = [HNPZixunDetailsVC new];
    zixunDetailsVC.zixunDetailsM = self.WZArray[indexPath.row];
    [self.navigationController pushViewController:zixunDetailsVC animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置Cell的动画效果为3D效果
       //设置x和y的初始值为0.1；
//       cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//       //x和y的最终值为1
//       [UIView animateWithDuration:0.5 animations:^{
//           cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//       }];
}

#pragma mark - 获取数据
//只有1页，每次上拉页数增加
-(void)WZJson:(NSNumber *)pageSize{
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       [manager GET:@"http://api.yysc.online/user/talk/getTalkListByProject" parameters:@{
           @"project":@"dingwulong",
           @"pageNumber":@1,
           @"pageSize":pageSize
       } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable result) {
            
             NSMutableArray *tempArray = [NSMutableArray new];
                   tempArray = [HNPZixunModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
           [self.tableview.mj_header endRefreshing];
           [self.tableview.mj_footer endRefreshing];
           
           NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
           NSArray *dataArray = [userDefault objectForKey:@"userCollectArray"];
           for (int i = 0; i < dataArray.count; i++) {
               NSDictionary *ID = dataArray[i];
               for (int i = 0; i < self.WZArray.count; i++) {
                   HNPZixunModel *zxModelArrayID = self.WZArray[i];
                   if ([ID[@"phone"] isEqualToString:zxModelArrayID.user.phone]) {
                       zxModelArrayID.isFollow = YES;
                   }
               }
           }
           
           self.WZArray = tempArray;
           [self.tableview reloadData];
                
            }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"failure--%@",error);
           [self.tableview.mj_header endRefreshing];
           [self.tableview.mj_footer endRefreshing];
        }];
    
}

@end
