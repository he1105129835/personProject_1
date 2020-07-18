//
//  HNPPMpubgController.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/1.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPPMpubgController.h"
#import "HNPZhanDuiCell.h"
#import "HNPPaiMingCell.h"
#import "HNPPaimingModel.h"
#import "HNPPaimingListModel.h"

@interface HNPPMpubgController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *PaimingArray;
@property (nonatomic, assign)NSInteger menuTag;

@end

@implementation HNPPMpubgController

static NSString *IDOne = @"zhanDuiCellID";
static NSString *IDTwo = @"paiMingCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    self.view.backgroundColor = UIColor.yellowColor;
}

#pragma mark - 加载tableView
-(void)loadTableView{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - ([UIApplication sharedApplication].statusBarFrame.size.height)) style:UITableViewStylePlain];
       [self.view addSubview:_tableview];
       _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
       _tableview.dataSource = self;
       _tableview.delegate = self;
       _tableview.bounces = NO;
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPZhanDuiCell class]) bundle:nil] forCellReuseIdentifier:IDOne];
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPPaiMingCell class]) bundle:nil] forCellReuseIdentifier:IDTwo];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        HNPPaimingModel *tempModel = self.PaimingArray[3];
        return tempModel.list.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
            HNPZhanDuiCell *zhanDuiCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
            return zhanDuiCell;
        }else{
            HNPPaiMingCell *paiMingCell = [tableView dequeueReusableCellWithIdentifier:IDTwo];
            HNPPaimingModel *temp = _PaimingArray[3];
            paiMingCell.paimingModel = temp.list[indexPath.row];
            return paiMingCell;
        }
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48.5;
}

#pragma mark - 数据加载

-(NSArray *)PaimingArray{
    if (_PaimingArray == nil) {
        [HNPPaimingModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                @"list" : [HNPPaimingListModel class]
            };
        }];
        _PaimingArray = [HNPPaimingModel mj_objectArrayWithFilename:@"teamList.plist"];
        // 按分数值排序
        NSSortDescriptor *tempDes = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
        NSMutableArray *rankTempArray = [NSMutableArray array];
        for (HNPPaimingModel *temp in _PaimingArray) {
            NSMutableArray *listArray = [NSMutableArray array];
            // 计算分数值
            for (HNPPaimingListModel *arr in temp.list) {
                arr.score = [NSNumber numberWithFloat:([arr.win floatValue] * 2 - [arr.lose floatValue])];
                
                arr.shenglv = [NSNumber numberWithFloat:[arr.win floatValue]/ ([arr.lose floatValue] + [arr.win floatValue]) * 100];
                
                [listArray addObject:arr];
            }

            temp.list = [listArray sortedArrayUsingDescriptors:@[tempDes]];

            [rankTempArray addObject:temp];
        }
        _PaimingArray = rankTempArray;
    }
    return _PaimingArray;
}

@end
