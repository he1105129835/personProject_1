//
//  HNPMyBattleCell.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNPBattleTeamModel.h"

@class HNPMyBattleCell;
@protocol HNPDeleteBtnDelegate <NSObject>

//点击展开按钮
-(void)MyBattleDeleteBtnDidClick:(HNPMyBattleCell *)myBattleDeleteCell;

@end

@interface HNPMyBattleCell : UITableViewCell

@property (nonatomic ,weak) id<HNPDeleteBtnDelegate> delegate;
@property (nonatomic,strong)HNPBattleTeamModel *battleTeamM;

@end
