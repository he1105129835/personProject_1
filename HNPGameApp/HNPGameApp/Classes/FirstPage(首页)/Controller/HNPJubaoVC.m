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
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 10, 15)];
    [backButton setBackgroundImage:[[UIImage imageNamed:@"btn_fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = item;
    self.navigationItem.title = @"举报";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //轻扫删除图片
    _addImageView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *deleteImageView = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDeleteView)];
    [self.addImageView addGestureRecognizer:deleteImageView];
    
    //举报按钮状态
    [self.jubaoBtn setBackgroundImage:[UIImage imageNamed:@"btn_kejubao"] forState:UIControlStateNormal];
    [self.jubaoBtn setBackgroundImage:[UIImage imageNamed:@"btn_bukejubao"] forState:UIControlStateDisabled];
    
    
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

//轻扫图片删除
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


#pragma mark - 举报按钮

- (IBAction)jubaoBtnClick:(id)sender {
    [MBProgressHUD showMessage:@"举报成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
}


@end
