//
//  HNPDianJingDetailsVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/2.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPDianJingDetailsVC.h"

@interface HNPDianJingDetailsVC ()

@property (weak, nonatomic) IBOutlet UIImageView *DJDetailsImageView;
@property (weak, nonatomic) IBOutlet UILabel *DJDetailsWangbaName;
@property (weak, nonatomic) IBOutlet UILabel *DJDetailsAddressLable;
@property (weak, nonatomic) IBOutlet UIImageView *xignxing_1;
@property (weak, nonatomic) IBOutlet UIImageView *xignxing_2;
@property (weak, nonatomic) IBOutlet UIImageView *xignxing_3;
@property (weak, nonatomic) IBOutlet UIImageView *xignxing_4;
@property (weak, nonatomic) IBOutlet UIImageView *xignxing_5;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property(nonatomic,strong)HNPPersonModel *mineUserInfoModel;


@end

@implementation HNPDianJingDetailsVC

- (void)viewWillAppear:(BOOL)animated{
    
    //电竞馆详情的传值
    [self.DJDetailsImageView sd_setImageWithURL:[NSURL URLWithString:_DJDetailsModel.pic] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    self.DJDetailsWangbaName.text = self.DJDetailsModel.name;
    self.DJDetailsAddressLable.text = self.DJDetailsModel.address;
    switch (_DJDetailsModel.star.intValue) {
        case 0:
            break;
        case 1:
            _xignxing_1.image = [UIImage imageNamed:@"pic_xing"];
            break;
        case 2:
            _xignxing_1.image = [UIImage imageNamed:@"pic_xing"];
            _xignxing_2.image = [UIImage imageNamed:@"pic_xing"];
            break;
        case 3:
            _xignxing_1.image = [UIImage imageNamed:@"pic_xing"];
            _xignxing_2.image = [UIImage imageNamed:@"pic_xing"];
            _xignxing_3.image = [UIImage imageNamed:@"pic_xing"];
            break;
        case 4:
            _xignxing_1.image = [UIImage imageNamed:@"pic_xing"];
            _xignxing_2.image = [UIImage imageNamed:@"pic_xing"];
            _xignxing_3.image = [UIImage imageNamed:@"pic_xing"];
            _xignxing_4.image = [UIImage imageNamed:@"pic_xing"];
            break;
            case 5:
            _xignxing_1.image = [UIImage imageNamed:@"pic_xing"];
            _xignxing_2.image = [UIImage imageNamed:@"pic_xing"];
            _xignxing_3.image = [UIImage imageNamed:@"pic_xing"];
            _xignxing_4.image = [UIImage imageNamed:@"pic_xing"];
            _xignxing_5.image = [UIImage imageNamed:@"pic_xing"];
            break;
        default:
            break;
    }
    [self setNavigation];
    
    //根据电竞馆是否收藏选择按钮状态
    if (self.DJDetailsModel.isCollect == NO) {
        self.collectionBtn.selected = NO;
    }else if(self.DJDetailsModel.isCollect == YES){
        self.collectionBtn.selected = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeView)];
    [self.view addGestureRecognizer:swipe];
}


#pragma mark - 方法调用

//收藏按钮
- (IBAction)collectionBtn:(id)sender {
    
    //判断按钮的状态
    self.collectionBtn.selected =! self.collectionBtn.selected;
    
    // 收藏状态更新
    self.DJDetailsModel.isCollect = self.DJDetailsModel.isCollect;
    // 取出本地收藏数据
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dataList = [[NSMutableDictionary alloc] init];
    NSArray *temp =[userDefault objectForKey:@"userCollectArray"];
    // 将不可变数组temp转为可变数组dataArray
    NSMutableArray *dataArray = [NSMutableArray array];
        for (int i = 0; i < temp.count; i++)
       {
           [dataArray addObject:temp[i]];
       }
       // 收藏
    if (self.collectionBtn.selected == YES) {
           // 添加id值和收藏状态
        [dataList setObject:self.DJDetailsModel.userid forKey:@"userid"];
        [dataList setObject:[NSNumber numberWithBool:self.DJDetailsModel.isCollect] forKey:@"isCollect"];
           [dataArray addObject:dataList];
           // 保存
           [userDefault setObject:dataArray forKey:@"userCollectArray"];
           [userDefault synchronize];
           
       }
       // 取消收藏
       else {
           // 判断id值删除对应的收藏
           for (int i = 0; i < dataArray.count; i++) {
               NSDictionary *ID = dataArray[i];
               if ([ID[@"userid"] isEqualToString:self.DJDetailsModel.userid]) {
                   [dataArray removeObjectAtIndex:i];
               }
           }
           // 保存
           [userDefault setObject:dataArray forKey:@"userCollectArray"];
           [userDefault synchronize];
       }
}
//轻扫返回
-(void)swipeView{
    [self.navigationController popViewControllerAnimated:YES];
}
//设置导航栏状态
-(void)setNavigation{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"电竞馆";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"dingbu"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}







@end
