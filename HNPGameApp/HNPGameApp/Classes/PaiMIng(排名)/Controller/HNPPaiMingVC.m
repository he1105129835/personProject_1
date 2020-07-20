//
//  HNPPaiMingVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/6/29.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPPaiMingVC.h"
#import "HNPZixunVC.h"
#import "HNPPMwzController.h"
#import "HNPPMLOLController.h"
#import "HNPPMswController.h"
#import "HNPPMpubgController.h"

#define statusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define statusBarWidth [UIApplication sharedApplication].statusBarFrame.size.width
#define screenWidth CGRectGetWidth(self.view.bounds)
#define screenHeight CGRectGetHeight(self.view.bounds)

@interface HNPPaiMingVC ()<FSSegmentTitleViewDelegate,FSPageContentViewDelegate>

@property (nonatomic ,strong)HNPZixunVC *ziXunVC;

@end

@implementation HNPPaiMingVC

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    self.title = @"排名";
    self.view.backgroundColor = UIColor.clearColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopView];
    
    
}




#pragma mark - 顶部控制器

-(void)loadTopView{
    HNPZixunVC *ziXunVC = [HNPZixunVC new];
        ziXunVC.flag = YES;
    [self addChildViewController:ziXunVC];
        [self.view addSubview:ziXunVC.view];
        ziXunVC.view.frame = self.view.bounds;
    //引用titleView
    self.titleView = ziXunVC.titleView;
    NSMutableArray *childVCs = [NSMutableArray new];
    
    HNPPMwzController *PMwzVC = [HNPPMwzController new];
    [childVCs addObject:PMwzVC];

    HNPPMLOLController *PMlolVC = [HNPPMLOLController new];
    [childVCs addObject:PMlolVC];

    HNPPMswController *PMswVC = [HNPPMswController new];
    [childVCs addObject:PMswVC];

    HNPPMpubgController *PMpubgVC = [HNPPMpubgController new];
    [childVCs addObject:PMpubgVC];
    
    ziXunVC.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, statusBarHeight + 50, statusBarWidth, self.view.frame.size.height + self.titleView.frame.size.height + 49) childVCs:childVCs parentVC:self delegate:self];
    [self.view addSubview:ziXunVC.pageContentView];
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    
    _titleView.selectIndex = endIndex;
}

@end
