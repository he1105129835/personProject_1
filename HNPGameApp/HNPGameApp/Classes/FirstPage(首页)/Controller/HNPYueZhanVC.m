//
//  HNPYueZhanVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/6/29.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPYueZhanVC.h"
#import "HNPYZCreatCell.h"
#import "HNPYZJiaruCell.h"
#import "HNPJubaoVC.h"

@interface HNPYueZhanVC ()<UITableViewDelegate,UITableViewDataSource,HNPJubaoBtnDelegate>

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation HNPYueZhanVC

static NSString *IDOne = @"creatCellID";
static NSString *IDTwo = @"jiaruCellID";

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"dingbu"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
}

-(void)loadTableView{
    //tableView的显示范围
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - (self.tabBarController.tabBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height)) style:UITableViewStylePlain];
    [self.view addSubview:_tableview];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPYZCreatCell class]) bundle:nil] forCellReuseIdentifier:IDOne];
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([HNPYZJiaruCell class]) bundle:nil] forCellReuseIdentifier:IDTwo];
}




#pragma mark - 加载tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HNPYZCreatCell *creatCell = [tableView dequeueReusableCellWithIdentifier:IDOne];
        if (indexPath.row == 0) {
            creatCell.TeamImageView_1.image = [UIImage imageNamed:@"EDG"];
            creatCell.TeamName_1.text = @"EDG";
            creatCell.TeamIamgeView_2.image = [UIImage imageNamed:@"LNG"];
            creatCell.TeamName_2.text = @"LNG";
        }
        return creatCell;
    }else{
        HNPYZJiaruCell *jiaruCell = [tableView dequeueReusableCellWithIdentifier:IDTwo];
        jiaruCell.delegate = self;
        if (indexPath.row == 0) {
            jiaruCell.jiaruImageView_1.image = [UIImage imageNamed:@"RNG"];
            jiaruCell.jiaruNameLable_1.text = @"RNG";
            jiaruCell.jiaruImageView_2.image = [UIImage imageNamed:@"IG"];
            jiaruCell.jiaruNameLable_2.text = @"IG";
        }else if (indexPath.row == 1){
            jiaruCell.jiaruImageView_1.image = [UIImage imageNamed:@"OMG"];
            jiaruCell.jiaruNameLable_1.text = @"OMG";
            jiaruCell.jiaruImageView_2.image = [UIImage imageNamed:@"FPX"];
            jiaruCell.jiaruNameLable_2.text = @"FPX";
        }else{
            jiaruCell.jiaruImageView_1.image = [UIImage imageNamed:@"TES"];
            jiaruCell.jiaruNameLable_1.text = @"TES";
            jiaruCell.jiaruImageView_2.image = [UIImage imageNamed:@"BLG"];
            jiaruCell.jiaruNameLable_2.text = @"BLG";
        }
        return jiaruCell;
    }
}

//tableView的表头设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
//        view1.backgroundColor = UIColor.whiteColor;
        UIButton *bottom1 = [UIButton new];
        [bottom1 setBackgroundImage:[UIImage imageNamed:@"chuangjianbisai"] forState:UIControlStateNormal];
        bottom1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5 - 47.5, 5, 95, 30);
        [view1 addSubview:bottom1];
        return view1;
    }else{
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        //        view1.backgroundColor = UIColor.whiteColor;
                UIButton *bottom1 = [UIButton new];
                [bottom1 setBackgroundImage:[UIImage imageNamed:@"jiarubisai"] forState:UIControlStateNormal];
                bottom1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5 - 47.5, 5, 95, 30);
                [view2 addSubview:bottom1];
                return view2;
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 183;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview deselectRowAtIndexPath:indexPath animated:NO];
}

//举报按钮
- (void)jubaoBtnDidClick:(HNPYZJiaruCell *)jiaruCell{
    HNPJubaoVC *jubaoVC = [HNPJubaoVC new];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:jubaoVC animated:YES];
}



@end
