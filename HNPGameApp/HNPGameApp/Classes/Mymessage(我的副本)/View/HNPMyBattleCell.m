//
//  HNPMyBattleCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMyBattleCell.h"

@interface HNPMyBattleCell ()

@property (weak, nonatomic) IBOutlet UIView *zhankaiView;

@property (weak, nonatomic) IBOutlet UIImageView *battleTeamNameHead_1;
@property (weak, nonatomic) IBOutlet UIImageView *battleTeamNameHead_2;
@property (weak, nonatomic) IBOutlet UILabel *battleTeamNameLable_1;
@property (weak, nonatomic) IBOutlet UILabel *battleTeamNameLable_2;
@property (weak, nonatomic) IBOutlet UILabel *gameNameLable;
@property (weak, nonatomic) IBOutlet UILabel *battlePublishTimeLable;



@end

@implementation HNPMyBattleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setBattleTeamM:(HNPBattleTeamModel *)battleTeamM{
    _battleTeamM = battleTeamM;
    self.battleTeamNameHead_1.image = [UIImage imageNamed:battleTeamM.battleTeamHead_1];
    self.battleTeamNameHead_2.image = [UIImage imageNamed:battleTeamM.battleTeamHead_2];
    self.battleTeamNameLable_1.text = battleTeamM.battleTeamName_1;
    self.battleTeamNameLable_2.text = battleTeamM.battleTeamName_2;
    self.gameNameLable.text = [NSString stringWithFormat:@"创建时间：%@",battleTeamM.fabuTime];
    self.battlePublishTimeLable.text = battleTeamM.fabuTime;
    
}

- (IBAction)zhankaiBtn:(id)sender {
    self.zhankaiView.hidden = !self.zhankaiView.hidden;
}


- (IBAction)deleteBtn:(id)sender {
    self.zhankaiView.hidden = !self.zhankaiView.hidden;
    if ([self.delegate respondsToSelector:@selector(MyBattleDeleteBtnDidClick:)]) {
        [self.delegate MyBattleDeleteBtnDidClick:self];
    }
}



@end
