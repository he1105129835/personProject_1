//
//  AppDelegate.m
//  HNPGameApp
//
//  Created by henanping on 2020/6/29.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "AppDelegate.h"
#import "HNPFirstPageVC.h"
#import "HNPZixunVC.h"
#import "HNPYueZhanVC.h"
#import "HNPFabuYuezhanVC.h"
#import "HNPPaiMingVC.h"
#import "HNPMyPersonVC.h"
#import "HNPMineVCViewController.h"
#import "HNPTabBar.h"

@interface AppDelegate ()



@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UITabBarController *tabC = [UITabBarController new];
//    tabC.tabBar.backgroundImage = [UIImage imageNamed:@"tab"];
//    tabC.tabBar.barTintColor = [UIColor clearColor];
    tabC.tabBar.backgroundColor = [UIColor blackColor];
//    [tabC setValue:[HNPTabBar new] forKeyPath:@"tabBar"];
    
    self.window.rootViewController = tabC;
    
    HNPFirstPageVC *FirstVC = [HNPFirstPageVC new];
    FirstVC.tabBarItem.title = @"首页";
    FirstVC.tabBarItem.image = [UIImage imageNamed:@"ic_shouye"];
    FirstVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_shouye_sel"];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:FirstVC];
    [tabC addChildViewController:nav1];
    
    HNPZixunVC *ZixunVC = [HNPZixunVC new];
    ZixunVC.tabBarItem.title = @"资讯";
    ZixunVC.tabBarItem.image = [UIImage imageNamed:@"ic_zixun"];
    ZixunVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_zixun_sel"];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:ZixunVC];    [tabC addChildViewController:nav2];
    
    HNPFabuYuezhanVC *fabuYueZhanVC = [HNPFabuYuezhanVC new];
    fabuYueZhanVC.tabBarItem.image = [UIImage imageNamed:@"ic_yuezhan"];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:fabuYueZhanVC];
        CGFloat offset = 5.0;
    nav3.tabBarItem.imageInsets = UIEdgeInsetsMake(-offset, 0, offset, 0);
    [nav3.navigationBar setBackgroundImage:[UIImage imageNamed:@"dingbu"] forBarMetrics:UIBarMetricsDefault];
    [nav3.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [tabC addChildViewController:nav3];
    
    
    HNPPaiMingVC *PaiMingVC = [HNPPaiMingVC new];
    PaiMingVC.tabBarItem.title = @"排名";
    PaiMingVC.tabBarItem.image = [UIImage imageNamed:@"ic_paiming"];
    PaiMingVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_paiming_sel"];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:PaiMingVC];
    [tabC addChildViewController:nav4];
    
    HNPMineVCViewController *MyPersonVC = [HNPMineVCViewController new];
    MyPersonVC.tabBarItem.title = @"我的";
    MyPersonVC.tabBarItem.image = [UIImage imageNamed:@"ic_wode"];
    MyPersonVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_wode_sel"];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:MyPersonVC];
    [tabC addChildViewController:nav5];
    
    [self.window makeKeyAndVisible];
    [self WhetherToLoginOrNot];
    return YES;
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
