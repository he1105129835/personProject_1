//
//  HNPMyFollowCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMyFollowCell.h"

@implementation HNPMyFollowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)QxMyFollowBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MyQxFollowBtnDidClick:)]) {
        [self.delegate MyQxFollowBtnDidClick:self];
    }
}

@end
