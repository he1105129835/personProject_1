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


@end

@implementation HNPMyZanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.zhidingWidth.constant = 0;
    self.wangzheWidth.constant = 0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
