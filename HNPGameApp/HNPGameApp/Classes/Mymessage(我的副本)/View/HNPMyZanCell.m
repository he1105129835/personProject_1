//
//  HNPMyZanCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMyZanCell.h"

@interface HNPMyZanCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhidingWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wangzheWidth;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;


@end

@implementation HNPMyZanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.zhidingWidth.constant = 0;
    self.wangzheWidth.constant = 0;
    // Initialization code
}

- (void)setZanGdM:(HNPZanGdModel *)ZanGdM{
    _ZanGdM = ZanGdM;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:ZanGdM.neirongImageView] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    self.contentLable.text = ZanGdM.neirongLable;
}

@end
