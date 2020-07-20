//
//  HNPTeamOneVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/14.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPTeamOneVC.h"
#import "HNPTeamCell.h"
#import "HNPPaimingModel.h"
#import "HNPPaimingListModel.h"

@interface HNPTeamOneVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *Array;

@end

@implementation HNPTeamOneVC

static NSString *IDOne = @"TeamCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    [self PaimingArray];
}

-(NSArray *)PaimingArray{
    if (_Array == nil) {
        [HNPPaimingModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                @"list" : [HNPPaimingListModel class]
            };
        }];
        _Array = [HNPPaimingModel mj_objectArrayWithFilename:@"teamList.plist"];
        
        // 按分数值排序
        NSSortDescriptor *tempDes = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
        NSMutableArray *rankTempArray = [NSMutableArray array];
        for (HNPPaimingModel *temp in _Array) {
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
        _Array = rankTempArray;
    }
    return _Array;
}


#pragma mark - Navigation

-(void)loadTableView{
    //tableView的显示范围
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - ([UIApplication sharedApplication].statusBarFrame.size.height)) style:UITableViewStylePlain];
    [self.view addSubview:_tableview];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPTeamCell class]) bundle:nil] forCellReuseIdentifier:IDOne];
    _tableview.estimatedRowHeight = 100;
    _tableview.rowHeight = UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.TeamTag == 0) {
        HNPPaimingModel *tempModel = self.Array[0];
        return tempModel.list.count;
    }else if (self.TeamTag == 1){
        HNPPaimingModel *tempModel = self.Array[1];
        return tempModel.list.count;
    }else if (self.TeamTag == 2){
        HNPPaimingModel *tempModel = self.Array[2];
        return tempModel.list.count;
    }else{
        HNPPaimingModel *tempModel = self.Array[3];
        return tempModel.list.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //根据不同的按钮tag值进行加载不同的组模型
    if (self.TeamTag == 0) {
        HNPTeamCell *teamCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
        HNPPaimingModel *temp = self.Array[0];
        teamCell.TeamModel = temp.list[indexPath.row];
        return teamCell;
    }else if (self.TeamTag == 1){
        HNPTeamCell *teamCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
        HNPPaimingModel *temp = self.Array[1];
        teamCell.TeamModel = temp.list[indexPath.row];
        return teamCell;
    }else if (self.TeamTag == 2){
        HNPTeamCell *teamCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
        HNPPaimingModel *temp = self.Array[2];
        teamCell.TeamModel = temp.list[indexPath.row];
        return teamCell;
    }else{
        HNPTeamCell *teamCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
        HNPPaimingModel *temp = self.Array[3];
        teamCell.TeamModel = temp.list[indexPath.row];
        return teamCell;
    }
    
}

//点击不同的组模型返回不同的数据
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview deselectRowAtIndexPath:indexPath animated:NO];
    if (self.TeamTag == 0) {
        HNPPaimingModel *listModel = self.Array[0];
        HNPPaimingListModel *paiMingModel = listModel.list[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(returnDataOneWhenClick:returnClick:)]) {
            [self.delegate returnDataOneWhenClick:self returnClick:paiMingModel];
        }
    }else if (self.TeamTag == 1){
        HNPPaimingModel *listModel = self.Array[1];
        HNPPaimingListModel *paiMingModel = listModel.list[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(returnDataOneWhenClick:returnClick:)]) {
            [self.delegate returnDataOneWhenClick:self returnClick:paiMingModel];
        }
    }else if (self.TeamTag == 2){
        HNPPaimingModel *listModel = self.Array[2];
        HNPPaimingListModel *paiMingModel = listModel.list[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(returnDataOneWhenClick:returnClick:)]) {
            [self.delegate returnDataOneWhenClick:self returnClick:paiMingModel];
        }
    }else{
        HNPPaimingModel *listModel = self.Array[3];
        HNPPaimingListModel *paiMingModel = listModel.list[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(returnDataOneWhenClick:returnClick:)]) {
            [self.delegate returnDataOneWhenClick:self returnClick:paiMingModel];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
