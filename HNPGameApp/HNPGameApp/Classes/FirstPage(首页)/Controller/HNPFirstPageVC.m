//
//  HNPFirstPageVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/6/29.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPFirstPageVC.h"
#import "HNPGameIconCell.h"
#import "HNPXuanzePlaceCell.h"
#import "HNPWangBaCell.h"
#import "HNPmoreCell.h"
#import "HNPBottomCell.h"
#import "HNPDianJingDetailsVC.h"
#import "HNPYueZhanVC.h"
#import "HNPDianJingDetailsVC.h"

@interface HNPFirstPageVC ()<UITableViewDelegate,UITableViewDataSource,HNPGameIconBtnDelegate,HNPHomeXuanzeBtnDetegate>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *DJArray;
@property(nonatomic,strong)NSArray *HotArray;

@end

@implementation HNPFirstPageVC

static NSString *IDOne = @"GameIconCellID";
static NSString *IDTwo = @"XuanzePlaceCellID";
static NSString *IDThree = @"WangBaCellID";
static NSString *IDFour = @"moreCellID";
static NSString *IDFive = @"BottomCellID";

/**判断当前为附近馆还是热门馆*/
BOOL flag_1 = 0;

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    self.title = @"首页";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
}


#pragma mark - 数据加载

-(NSArray *)DJArray{
    if (_DJArray == nil) {
        _DJArray = [HNPDianJingModel mj_objectArrayWithFilename:@"DJClub.plist"];
    }
    return _DJArray;
}

//热门馆数据加载
-(NSArray *)HotArray{
    if (_HotArray == nil) {
        _HotArray = [HNPDianJingModel mj_objectArrayWithFilename:@"DJClub.plist"];
        NSSortDescriptor *tempDes = [NSSortDescriptor sortDescriptorWithKey:@"star" ascending:NO];
        NSArray *tempArray = [_HotArray sortedArrayUsingDescriptors:@[tempDes]];
        _HotArray = tempArray;
    }
    return _HotArray;
}

#pragma mark - 协议及方法

-(void)loadTableView{
    //在view上添加一个tableview
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - ([UIApplication sharedApplication].statusBarFrame.size.height)) style:UITableViewStylePlain];
    
    [self.view addSubview:_tableview];
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.bounces = NO;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.estimatedRowHeight = 100;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPGameIconCell class]) bundle:nil] forCellReuseIdentifier:IDOne];
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPXuanzePlaceCell class]) bundle:nil] forCellReuseIdentifier:IDTwo];
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPWangBaCell class]) bundle:nil] forCellReuseIdentifier:IDThree];
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPmoreCell class]) bundle:nil] forCellReuseIdentifier:IDFour];
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPBottomCell class]) bundle:nil] forCellReuseIdentifier:IDFive];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if(section == 2){
        return 2;
    }else if (section == 3){
        return 1;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     if (indexPath.section == 0) {
                HNPGameIconCell *gameCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
                gameCell.delegate = self;
                return gameCell;
     }else if(indexPath.section == 1){
                HNPXuanzePlaceCell *xuanZeCell = [tableView dequeueReusableCellWithIdentifier:IDTwo];
         xuanZeCell.delegate = self;
                return xuanZeCell;
     }else if(indexPath.section == 2){
         if (flag_1 == 0) {
             HNPWangBaCell *wangBaCell = [tableView dequeueReusableCellWithIdentifier:IDThree];
             wangBaCell.DJModel = self.DJArray[indexPath.row];
                    return wangBaCell;
         } else {
             HNPWangBaCell *wangBaCell = [tableView dequeueReusableCellWithIdentifier:IDThree];
             wangBaCell.DJModel = self.HotArray[indexPath.row];
                    return wangBaCell;
         }
     }else if (indexPath.section == 3){
                HNPmoreCell *moreCell = [tableView dequeueReusableCellWithIdentifier:IDFour];
                return moreCell;
     }else{
                HNPBottomCell *bottomCell = [tableView dequeueReusableCellWithIdentifier:IDFive];
                return bottomCell;
     }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 2) {
        if (flag_1 == 0) {
            HNPDianJingDetailsVC *DjDetailsVC = [HNPDianJingDetailsVC new];
            DjDetailsVC.DJDetailsModel = self.DJArray[indexPath.row];
            self.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:DjDetailsVC animated:YES];
        }else{
            HNPDianJingDetailsVC *DjDetailsVC = [HNPDianJingDetailsVC new];
            DjDetailsVC.DJDetailsModel = self.HotArray[indexPath.row];
            self.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:DjDetailsVC animated:YES];
        }
    }else{
    }
}

#pragma mark - 自定义协议

- (void)WZBtnDidClick:(HNPGameIconCell *)IconCell{
    HNPYueZhanVC *yuezhanVC = [HNPYueZhanVC new];
    yuezhanVC.navigationItem.title = @"王者荣耀";
    [self.navigationController pushViewController:yuezhanVC animated:YES];
}
- (void)LOLBtnDidClick:(HNPGameIconCell *)IconCell{
    HNPYueZhanVC *yuezhanVC = [HNPYueZhanVC new];
    yuezhanVC.navigationItem.title = @"英雄联盟";
    [self.navigationController pushViewController:yuezhanVC animated:YES];
}
- (void)SWBtnDidClick:(HNPGameIconCell *)IconCell{
    HNPYueZhanVC *yuezhanVC = [HNPYueZhanVC new];
    yuezhanVC.navigationItem.title = @"守望先锋";
    [self.navigationController pushViewController:yuezhanVC animated:YES];
    
}
- (void)PUBGBtnDidClick:(HNPGameIconCell *)IconCell{
    HNPYueZhanVC *yuezhanVC = [HNPYueZhanVC new];
    yuezhanVC.navigationItem.title = @"绝地求生";
    [self.navigationController pushViewController:yuezhanVC animated:YES];
}

//选择热门电竞馆代理
- (void)HomeXuzanzeFujinBtnDidClick:(HNPXuanzePlaceCell *)HomeXuanzeCell{
    flag_1 = 0;
    [self.tableview reloadData];
}
- (void)HomeXuzanzeHotBtnDidClick:(HNPXuanzePlaceCell *)HomeXuanzeCell{
    flag_1 = 1;
    [self.tableview reloadData];
}

@end
