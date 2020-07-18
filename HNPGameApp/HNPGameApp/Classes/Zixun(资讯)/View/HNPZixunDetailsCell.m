//
//  HNPZixunDetailsCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPZixunDetailsCell.h"
#import <SDWebImage/SDWebImage.h>
#import <sys/utsname.h>
#import "HNPFollowGdModel.h"
#import "HNPFollowGdModelArray.h"

@interface HNPZixunDetailsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *detailsHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailsNickName;
@property (weak, nonatomic) IBOutlet UILabel *detailsTitleLable;
@property (weak, nonatomic) IBOutlet UIImageView *detailsNeirongImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailsContent;
@property (weak, nonatomic) IBOutlet UILabel *detailsBrowserCount;
@property (weak, nonatomic) IBOutlet UILabel *detailsCommentCount;
@property (weak, nonatomic) IBOutlet UILabel *detailsFollowCount;
@property (weak, nonatomic) IBOutlet UILabel *detailsPublishTime;

@property(nonatomic,strong)HNPFollowGdModel *myFollowM;
@property(nonatomic,strong)NSString *followHead;


@end

@implementation HNPZixunDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    }

//数据赋值
- (void)setDetailsModle:(HNPZixunModel *)DetailsModle{
    _DetailsModle = DetailsModle;
    [self.detailsHeaderImageView sd_setImageWithURL:[NSURL URLWithString:DetailsModle.user.head] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    self.followHead = DetailsModle.user.head;
    [self.detailsNeirongImageView sd_setImageWithURL:[NSURL URLWithString:self.DetailsModle.picture] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    self.detailsNickName.text = DetailsModle.user.nickName;
    self.detailsBrowserCount.text = DetailsModle.browserCount;
    self.detailsCommentCount.text = DetailsModle.commentCount;
    self.detailsFollowCount.text = DetailsModle.user.fansCount;
    self.detailsContent.text = DetailsModle.content;
    if (DetailsModle.content.length < 20) {
        self.detailsTitleLable.text = [DetailsModle.content substringToIndex:DetailsModle.content.length];
    }else{
        self.detailsTitleLable.text = [DetailsModle.content substringToIndex:20];
    }
    self.detailsPublishTime.text = [NSString stringWithFormat:@"发表于 %@",[HNPZixunDetailsCell timetampTostring:DetailsModle.publishTime.integerValue]];
}

//时间戳
+(NSString *)timetampTostring:(long)timestamp{
    
    NSString *tempTime =[[NSNumber numberWithLong:timestamp] stringValue];
    NSMutableString *getTime = [NSMutableString stringWithFormat:@"%@",tempTime];

      //    NSMutableString *getTime = @"1461896616000";
     struct utsname systemInfo;
     uname(&systemInfo);

     [getTime deleteCharactersInRange:NSMakeRange(10,3)];
     NSDateFormatter *matter = [[NSDateFormatter alloc]init];
    matter.dateFormat =@"YYYY-MM-dd HH:mm";
//    matter.dateFormat = @"YYYY-MM-dd";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[getTime intValue]];

      NSString *timeStr = [matter stringFromDate:date];
    return timeStr;
}

#pragma mark - 点击关注进行归档
- (IBAction)followBtnClick:(id)sender {
    [MBProgressHUD showMessage:@"关注成功"];
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [MBProgressHUD hideHUD];
                   HNPFollowGdModel *myFollowM = [HNPFollowGdModel new];
                   myFollowM.userHead = self.followHead;
                   myFollowM.userNickname = self.detailsNickName.text;
                   NSString *filePath1 = [NSTemporaryDirectory() stringByAppendingPathComponent:@"myFollow.data"];
                   NSLog(@"%@",NSTemporaryDirectory());
                   //解档
                   HNPFollowGdModelArray *tempFollowArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath1];
                   if (tempFollowArray.followGdArray == nil) {
                       tempFollowArray = [HNPFollowGdModelArray new];
                       tempFollowArray.followGdArray = [NSMutableArray new];
                   }
                   [tempFollowArray.followGdArray addObject:myFollowM];
                   NSString *temp = NSTemporaryDirectory();
                   NSString *filePath = [temp stringByAppendingPathComponent:@"myFollow.data"];
                   //归档
                   [NSKeyedArchiver archiveRootObject:tempFollowArray toFile:filePath];
               });
}


@end
