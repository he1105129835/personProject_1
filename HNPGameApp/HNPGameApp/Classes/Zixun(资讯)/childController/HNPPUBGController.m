//
//  HNPPUBGController.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/1.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPPUBGController.h"
#import "HNPziXunCell.h"
#import "HNPZixunDetailsVC.h"

@interface HNPPUBGController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSDictionary *jsonDict;
@property(nonatomic,strong)NSArray *WZArray;

@end

@implementation HNPPUBGController

static NSString *IDOne = @"ziXunCellID";

- (void)viewWillAppear:(BOOL)animated{
    [self WZJson];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
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
    ziXunCell.zixunFabuNameLable.text = @"·绝地求生·";
    return ziXunCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview deselectRowAtIndexPath:indexPath animated:NO];
    HNPZixunDetailsVC *zixunDetailsVC = [HNPZixunDetailsVC new];
    zixunDetailsVC.zixunDetailsM = self.WZArray[indexPath.row];
    [self.navigationController pushViewController:zixunDetailsVC animated:YES];
}


#pragma mark - 获取数据

-(void)WZJson{
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       [manager GET:@"http://api.yysc.online/user/talk/getTalkListByProject" parameters:@{
           @"project":@"dingwulong",
           @"pageNumber":@1,
           @"pageSize":@10
       } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable result) {
            
             NSMutableArray *tempArray = [NSMutableArray new];
                   tempArray = [HNPZixunModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
           NSMutableArray *tempArray_1 = [NSMutableArray array];
           for (HNPZixunModel *model in tempArray) {
               NSRange range = [model.content rangeOfString:@"绝地求生"];
               if (range.location != NSNotFound) {
                   [tempArray_1 addObject:model];
               }
           }
           self.WZArray = tempArray_1;
           [self.tableview reloadData];
                
            }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"failure--%@",error);
        }];
    
}

@end
