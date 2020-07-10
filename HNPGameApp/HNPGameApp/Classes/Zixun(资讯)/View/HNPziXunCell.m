//
//  HNPziXunCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/1.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPziXunCell.h"
#import <SDWebImage/SDWebImage.h>

@interface HNPziXunCell ()

@property (weak, nonatomic) IBOutlet UIImageView *zixunImageView;
@property (weak, nonatomic) IBOutlet UILabel *zixunContent;
@property (weak, nonatomic) IBOutlet UILabel *zixunbrowserCount;
@property (weak, nonatomic) IBOutlet UILabel *zixunCommentVount;
@property (weak, nonatomic) IBOutlet UILabel *zixunFollowCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhidingWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wangzheWidth;


@end

@implementation HNPziXunCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.zhidingWidth.constant = 0;
    self.wangzheWidth.constant = 0;
}

- (void)setZixunMdoel:(HNPZixunModel *)zixunMdoel{
    _zixunMdoel = zixunMdoel;
    
    [self.zixunImageView sd_setImageWithURL:[NSURL URLWithString:self.zixunMdoel.picture] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    self.zixunContent.text = self.zixunMdoel.content;
    self.zixunbrowserCount.text = self.zixunMdoel.browserCount;
    self.zixunCommentVount.text = self.zixunMdoel.commentCount;
    self.zixunFollowCount.text = self.zixunMdoel.user.fansCount;
    
}



@end
