//
//  HNPSWController.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/1.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPSWController.h"
#import "HNPziXunCell.h"
#import "HNPZixunDetailsVC.h"

@interface HNPSWController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSDictionary *jsonDict;
@property(nonatomic,strong)NSArray *WZArray;
//每页页数
@property int moreDataFlag;
/**数据模型数组*/
@property (strong, nonatomic) NSMutableArray *zixunArray;

@end

@implementation HNPSWController

static NSString *IDOne = @"ziXunCellID";

- (void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    [self WZJson:@1 moreData:NO];
    self.moreDataFlag = 1;
//    self.zixunArray = [NSMutableArray array];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self WZJson:@1 moreData:NO];
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        int flag = 1 + self.moreDataFlag;
        [self WZJson:[NSNumber numberWithInt:flag] moreData:YES];
        self.moreDataFlag += 1;
    }];
}

-(void)loadTableView{
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
    ziXunCell.zixunFabuNameLable.text = @"·守望先锋·";
    return ziXunCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview deselectRowAtIndexPath:indexPath animated:NO];
    HNPZixunDetailsVC *zixunDetailsVC = [HNPZixunDetailsVC new];
    zixunDetailsVC.zixunDetailsM = self.WZArray[indexPath.row];
    [self.navigationController pushViewController:zixunDetailsVC animated:YES];
}

#pragma mark - 获取数据
-(void)WZJson:(NSNumber *)pageNumber moreData:(BOOL)moreData{
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       [manager GET:@"http://api.yysc.online/user/talk/getTalkListByProject" parameters:@{
           @"project":@"dingwulong",
           @"pageNumber":pageNumber,
           @"pageSize":@2
       } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable result) {
            
             NSMutableArray *tempArray = [NSMutableArray new];
                   tempArray = [HNPZixunModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
           // 刷新模式
           if (moreData == NO) {
               self.moreDataFlag = 1;
               [self.zixunArray removeAllObjects];
               for (HNPZixunModel *popularNewsModel in tempArray) {
                   [self.zixunArray addObject:popularNewsModel];
               }
               [self.tableview reloadData];
           }
           // 加载更多模式
           else {
               NSMutableArray *indexPathArray = [NSMutableArray array];
               for (HNPZixunModel *popularNewsModel in tempArray) {
                   [self.zixunArray addObject:popularNewsModel];
                   if (self.zixunArray.count) {
                       NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.zixunArray.count - 1 inSection:0];
                       [indexPathArray addObject:indexPath];
                   }
               }
               [self.tableview insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
           }
           [self.tableview.mj_header endRefreshing];
           [self.tableview.mj_footer endRefreshing];
           NSMutableArray *tempArray_1 = [NSMutableArray array];
           for (HNPZixunModel *model in tempArray) {
               NSRange range = [model.content rangeOfString:@"的"];
               if (range.location != NSNotFound) {
                   [tempArray_1 addObject:model];
               }
           }
           self.WZArray = tempArray_1;
           [self.tableview reloadData];
                
            }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"failure--%@",error);
           [self.tableview.mj_header endRefreshing];
           [self.tableview.mj_footer endRefreshing];
        }];
    
}
@end
