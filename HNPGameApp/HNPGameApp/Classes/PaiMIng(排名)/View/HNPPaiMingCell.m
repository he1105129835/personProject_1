//
//  HNPPaiMingCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/1.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPPaiMingCell.h"
#import "HNPPaimingModel.h"

@interface HNPPaiMingCell ()

@property (weak, nonatomic) IBOutlet UIImageView *paimingIconName;
@property (weak, nonatomic) IBOutlet UILabel *paimingTeamName;
@property (weak, nonatomic) IBOutlet UILabel *paimingshenglv;
@property (weak, nonatomic) IBOutlet UILabel *paimingScore;


@end

@implementation HNPPaiMingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPaimingModel:(HNPPaimingListModel *)paimingModel{
    _paimingModel = paimingModel;
    self.paimingTeamName.text = paimingModel.teamName;
    self.paimingIconName.image = [UIImage imageNamed:paimingModel.iconName];
    float tempShengLv = [paimingModel.shenglv floatValue];
    self.paimingshenglv.text = [NSString stringWithFormat:@"%.f%%",tempShengLv];
    self.paimingScore.text = paimingModel.score.stringValue;
    
}



@end
