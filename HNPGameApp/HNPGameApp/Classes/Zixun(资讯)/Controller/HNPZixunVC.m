//
//  HNPZixunVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/6/29.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPZixunVC.h"
#import "HNPWZController.h"
#import "HNPLOLController.h"
#import "HNPSWController.h"
#import "HNPPUBGController.h"
#import "FSPageContentView.h"
//#import <FSScrollContentView/FSPageContentView.h>

#define statusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define statusBarWidth [UIApplication sharedApplication].statusBarFrame.size.width
#define screenWidth CGRectGetWidth(self.view.bounds)
#define screenHeight CGRectGetHeight(self.view.bounds)

@interface HNPZixunVC ()<FSSegmentTitleViewDelegate,FSPageContentViewDelegate>

@end

@implementation HNPZixunVC

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    self.title = @"资讯";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //顶部控制器的切换
    [self topViewController];
    
    
}

#pragma mark - 顶部控制器

-(void)topViewController{
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, statusBarHeight, [UIScreen mainScreen].bounds.size.width, 50)titles:@[@"王者荣耀",@"英雄联盟",@"守望先锋",@"绝地求生"] delegate:self indicatorType:0];
    self.titleView.titleNormalColor = [UIColor whiteColor];
    self.titleView.titleSelectColor = [UIColor blackColor];
    self.titleView.indicatorColor = [UIColor blackColor];
    self.titleView = _titleView;
    [self.view addSubview:_titleView];
    if (_flag == YES) {
        //
    }else{
        NSMutableArray *childVCs = [NSMutableArray new];
           
           HNPWZController *wzVC = [HNPWZController new];
           [childVCs addObject:wzVC];

           HNPLOLController *lolVC = [HNPLOLController new];
           [childVCs addObject:lolVC];
               
           HNPSWController *swVC = [HNPSWController new];
           [childVCs addObject:swVC];
           
           HNPPUBGController *pubgVC = [HNPPUBGController new];
           [childVCs addObject:pubgVC];
           
           self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, statusBarHeight + _titleView.frame.size.height, statusBarWidth, screenHeight - (statusBarHeight + _titleView.frame.size.height + 44)) childVCs:childVCs parentVC:self delegate:self];
                   [self.view addSubview:_pageContentView];
        
    }
   
}

- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    _pageContentView.contentViewCurrentIndex = endIndex;
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    _titleView.selectIndex = endIndex;
}

@end
