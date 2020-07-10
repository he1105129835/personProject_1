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


@end

@implementation HNPDianJingDetailsVC

- (void)viewWillAppear:(BOOL)animated{
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeView)];
    [self.view addGestureRecognizer:swipe];
    
    
}


#pragma mark - 方法调用

-(void)swipeView{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setNavigation{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"电竞馆";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"dingbu"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}







@end
