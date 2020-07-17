//
//  HNPMyFollowCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMyFollowCell.h"

@interface HNPMyFollowCell ()

@property (weak, nonatomic) IBOutlet UIImageView *followHead;
@property (weak, nonatomic) IBOutlet UILabel *followNickname;


@end

@implementation HNPMyFollowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFollowGdM:(HNPFollowGdModel *)followGdM{
    _followGdM = followGdM;
    [self.followHead sd_setImageWithURL:[NSURL URLWithString:followGdM.userHead] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    self.followNickname.text = followGdM.userNickname;
}

- (IBAction)QxMyFollowBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MyQxFollowBtnDidClick:)]) {
        [self.delegate MyQxFollowBtnDidClick:self];
    }
}

@end
