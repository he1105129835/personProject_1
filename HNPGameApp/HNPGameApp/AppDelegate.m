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
#import "HNPPaiMingVC.h"
#import "HNPMyPersonVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UITabBarController *tabC = [UITabBarController new];
//    [tabC.tabBar setBackgroundImage:[UIImage imageNamed:@"tab"]];
//    tabC.tabBar.backgroundImage = [UIImage imageNamed:@"tab"];
//    tabC.tabBar.barTintColor = [UIColor clearColor];
//    tabC.tabBar.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = tabC;
    
    HNPFirstPageVC *FirstVC = [HNPFirstPageVC new];
    FirstVC.tabBarItem.title = @"首页";
    FirstVC.tabBarItem.image = [UIImage imageNamed:@"ic_shouye"];
    FirstVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_shouye_sel"];
    [tabC addChildViewController:FirstVC];
    
    HNPZixunVC *ZixunVC = [HNPZixunVC new];
    ZixunVC.tabBarItem.title = @"资讯";
    ZixunVC.tabBarItem.image = [UIImage imageNamed:@"ic_zixun"];
    ZixunVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_zixun_sel"];
    [tabC addChildViewController:ZixunVC];
    
    HNPYueZhanVC *YueZhanVC = [HNPYueZhanVC new];
    YueZhanVC.tabBarItem.image = [UIImage imageNamed:@"ic_yuezhan"];
    [tabC addChildViewController:YueZhanVC];
    
    HNPPaiMingVC *PaiMingVC = [HNPPaiMingVC new];
    PaiMingVC.tabBarItem.title = @"排名";
    PaiMingVC.tabBarItem.image = [UIImage imageNamed:@"ic_paiming"];
    PaiMingVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_paiming_sel"];
    [tabC addChildViewController:PaiMingVC];
    
    HNPMyPersonVC *MyPersonVC = [HNPMyPersonVC new];
    MyPersonVC.tabBarItem.title = @"我的";
    MyPersonVC.tabBarItem.image = [UIImage imageNamed:@"ic_wode"];
    MyPersonVC.tabBarItem.selectedImage = [UIImage imageNamed:@"ic_wode_sel"];
    [tabC addChildViewController:MyPersonVC];
    
    [self.window makeKeyAndVisible];
    return YES;
}


//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
