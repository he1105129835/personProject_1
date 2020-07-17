//
//  HNPTeamCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/14.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPTeamCell.h"

@interface HNPTeamCell ()

@property (weak, nonatomic) IBOutlet UIImageView *TeamImageView;
@property (weak, nonatomic) IBOutlet UILabel *TeamLable;


@end

@implementation HNPTeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTeamModel:(HNPPaimingListModel *)TeamModel{
    _TeamModel = TeamModel;
    self.TeamImageView.image = [UIImage imageNamed:self.TeamModel.iconName];
    self.TeamLable.text = self.TeamModel.teamName;
    
}


@end
