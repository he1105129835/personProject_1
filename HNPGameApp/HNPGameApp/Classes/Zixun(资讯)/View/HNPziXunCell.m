//
//  HNPziXunCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/1.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPziXunCell.h"
#import <SDWebImage/SDWebImage.h>
#import "HNPZanGdModel.h"
#import "HNPZanGdModelArray.h"

@interface HNPziXunCell ()

@property (weak, nonatomic) IBOutlet UIImageView *zixunImageView;
@property (weak, nonatomic) IBOutlet UILabel *zixunContent;
@property (weak, nonatomic) IBOutlet UILabel *zixunbrowserCount;
@property (weak, nonatomic) IBOutlet UILabel *zixunCommentVount;
@property (weak, nonatomic) IBOutlet UILabel *zixunFollowCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhidingWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wangzheWidth;

@property(nonatomic,strong)HNPZanGdModel *myZanM;
@property(nonatomic,strong)NSString *neirongHead;


@end

@implementation HNPziXunCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.zhidingWidth.constant = 0;
    self.wangzheWidth.constant = 0;
}

- (void)setZixunMdoel:(HNPZixunModel *)zixunMdoel{
    _zixunMdoel = zixunMdoel;
    
    [self.zixunImageView sd_setImageWithURL:[NSURL URLWithString:zixunMdoel.picture] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    self.neirongHead = zixunMdoel.picture;
    self.zixunContent.text = self.zixunMdoel.content;
    self.zixunbrowserCount.text = self.zixunMdoel.browserCount;
    self.zixunCommentVount.text = self.zixunMdoel.commentCount;
    self.zixunFollowCount.text = self.zixunMdoel.user.fansCount;
}

- (IBAction)zanBtn:(id)sender {
    [MBProgressHUD showMessage:@"点赞成功"];
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [MBProgressHUD hideHUD];
                   HNPZanGdModel *myZanM = [HNPZanGdModel new];
                   myZanM.neirongImageView = self.neirongHead;
                   myZanM.neirongLable = self.zixunContent.text;
                   NSString *filePath1 = [NSTemporaryDirectory() stringByAppendingPathComponent:@"myZan.data"];
                   NSLog(@"%@",NSTemporaryDirectory());
                   //解档
                   HNPZanGdModelArray *tempZanArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath1];
                   if (tempZanArray.zanGdArray == nil) {
                       tempZanArray = [HNPZanGdModelArray new];
                       tempZanArray.zanGdArray = [NSMutableArray new];
                   }
                   [tempZanArray.zanGdArray addObject:myZanM];
                   NSString *temp = NSTemporaryDirectory();
                   NSString *filePath = [temp stringByAppendingPathComponent:@"myZan.data"];
                   //归档
                   [NSKeyedArchiver archiveRootObject:tempZanArray toFile:filePath];
               });
}


@end
