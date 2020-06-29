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

@interface HNPFirstPageVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation HNPFirstPageVC

static NSString *IDOne = @"GameIconCellID";
static NSString *IDTwo = @"XuanzePlaceCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    //在view上添加一个tableview
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - ([UIApplication sharedApplication].statusBarFrame.size.height)) style:UITableViewStylePlain];
    [self.view addSubview:_tableview];
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.estimatedRowHeight = 100;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPGameIconCell class]) bundle:nil] forCellReuseIdentifier:IDOne];
       [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPXuanzePlaceCell class]) bundle:nil] forCellReuseIdentifier:IDTwo];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     if (indexPath.section == 0) {
                HNPGameIconCell *gameCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
                gameCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return gameCell;
            } else {
                HNPXuanzePlaceCell *xuanZeCell = [tableView dequeueReusableCellWithIdentifier:IDTwo];
                xuanZeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                //NSLog(@"%zd-%p",indexPath.row,DynamicCell);
                return xuanZeCell;
            }
}



@end
