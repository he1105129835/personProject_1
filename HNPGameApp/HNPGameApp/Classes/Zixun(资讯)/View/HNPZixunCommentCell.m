//
//  HNPZixunCommentCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPZixunCommentCell.h"
#import <SDWebImage/SDWebImage.h>

@interface HNPZixunCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *CommentHeader;
@property (weak, nonatomic) IBOutlet UILabel *CommentNickName;
@property (weak, nonatomic) IBOutlet UILabel *CommentPublishTime;
@property (weak, nonatomic) IBOutlet UILabel *CommentContent;


@end

@implementation HNPZixunCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUserModel:(HNPZixunModel *)UserModel{
    _UserModel = UserModel;
    [self.CommentHeader sd_setImageWithURL:[NSURL URLWithString:self.UserModel.user.head] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    self.CommentNickName.text = UserModel.user.nickName;
    self.CommentContent.text = UserModel.content;
}


@end
