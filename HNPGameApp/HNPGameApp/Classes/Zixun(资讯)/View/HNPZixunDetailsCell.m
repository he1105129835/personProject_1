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


@end

@implementation HNPZixunDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDetailsModle:(HNPZixunModel *)DetailsModle{
    _DetailsModle = DetailsModle;
    [self.detailsHeaderImageView sd_setImageWithURL:[NSURL URLWithString:self.DetailsModle.user.head] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
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

@end
