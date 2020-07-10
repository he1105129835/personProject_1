//
//  HNPYZCreatCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/2.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPYZCreatCell.h"

@interface HNPYZCreatCell ()

@property (weak, nonatomic) IBOutlet UIImageView *blueImageView;


@end

@implementation HNPYZCreatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.blueImageView.layer.cornerRadius = 10;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
