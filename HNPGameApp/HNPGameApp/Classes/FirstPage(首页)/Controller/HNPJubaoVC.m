//
//  HNPJubaoVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/2.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPJubaoVC.h"
#import "SelectPhotoManager.h"

@interface HNPJubaoVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,selectPhotoDelegate>

@property (weak, nonatomic) IBOutlet UITextView *jubaoLable;
@property (weak, nonatomic) IBOutlet UIImageView *addImageView;
@property (weak, nonatomic) IBOutlet UIButton *openPictureBtn;
@property (nonatomic,strong)SelectPhotoManager *photoManger;
@property (weak, nonatomic) IBOutlet UIButton *jubaoBtn;


@end

@implementation HNPJubaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //相册的调用
    [self setphotoImage];
    self.navigationItem.title = @"举报";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //轻扫返回上个界面手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeView)];
    [self.view addGestureRecognizer:swipe];
    //轻扫删除图片
    _addImageView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *deleteImageView = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDeleteView)];
    [self.addImageView addGestureRecognizer:deleteImageView];
    
    //举报按钮状态
    [self.jubaoBtn setBackgroundImage:[UIImage imageNamed:@"btn_kejubao"] forState:UIControlStateNormal];
    [self.jubaoBtn setBackgroundImage:[UIImage imageNamed:@"btn_bukejubao"] forState:UIControlStateDisabled];
    self.jubaoBtn.enabled = NO;
    
    
    
}

-(void)swipeView{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)swipeDeleteView{
    self.addImageView.image = nil;
}


//添加相机的点击手势
- (void)setphotoImage{
    self.openPictureBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoClick:)];
    [self.openPictureBtn addGestureRecognizer:tap];
    UIImage *img = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults]objectForKey:@"photoView"]];
    if (img) {
        self.addImageView.image = img;
    }
}

- (void)photoClick:(UITapGestureRecognizer *)recognizer{
    
   if (!_photoManger) {
       _photoManger = [[SelectPhotoManager alloc]init];
       _photoManger.delegate = self;
   }
      [_photoManger startSelectPhotoWithImageName:@"选择头像"];
           __weak typeof (self)mySelf = self;
           _photoManger.successHandle = ^(SelectPhotoManager *manager, UIImage *image) {
               mySelf.addImageView.image = image;
              
           };
}


#pragma mark - Navigation



@end
