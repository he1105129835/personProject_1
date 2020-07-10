//
//  HNPMineVCViewController.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/7.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMineVCViewController.h"
#import "HNPLoginVC.h"
#import "HNPMyPersonVC.h"

@interface HNPMineVCViewController ()

@property(nonatomic,strong)HNPPersonModel *mineUserInfoModel;

@end

@implementation HNPMineVCViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    self.title = @"我的";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVC];
    [self loadViewOneOrTwo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zhuxiao) name:@"zhuxiao" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zhuxiao) name:@"LoginSuccess" object:nil];
}

-(void)zhuxiao{
    [self loadViewOneOrTwo];
}
-(void)LoginSuccess{
    [self loadViewOneOrTwo];
}

-(void)addChildVC{
    NSArray *childClassName = @[@"HNPLoginVC",@"HNPMyPersonVC"];
    for (NSString *className in childClassName) {
        UIViewController *vc = [[NSClassFromString(className) alloc]init];
        [self addChildViewController:vc];
    }
    UIViewController *vc = self.childViewControllers[0];
    vc.view.frame = self.view.bounds;
    [self.view addSubview:vc.view];
}
-(void)loadViewOneOrTwo{
    //判断是否登录
    [self WhetherToLoginOrNot];
    if (self.login == YES) {
        UIViewController *preVC = self.childViewControllers[0];
        [preVC.view removeFromSuperview];
        UIViewController *curVC = self.childViewControllers[1];
        [self.view addSubview:curVC.view];
    }else{
        UIViewController *preVC = self.childViewControllers[1];
        [preVC.view removeFromSuperview];
        UIViewController *curVC = self.childViewControllers[0];
        curVC.view.frame = self.view.bounds;
        [self.view addSubview:curVC.view];
    }
}

#pragma mark - 判断是否登录

-(void)WhetherToLoginOrNot{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
    self.mineUserInfoModel = [HNPPersonModel mj_objectWithFile:path];
    if (self.mineUserInfoModel == nil) {
        self.login = NO;
    }else{
        self.login = YES;
    }
}



@end
