//
//  HNPMyFollowCell.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNPFollowGdModel.h"

@class HNPMyFollowCell;
@protocol HNPQXFollowBtnDelegate <NSObject>

//点击关注按钮
-(void)MyQxFollowBtnDidClick:(HNPMyFollowCell *)myFollowCell;

@end

@interface HNPMyFollowCell : UITableViewCell

@property (nonatomic ,weak) id<HNPQXFollowBtnDelegate> delegate;
@property (nonatomic,strong)HNPFollowGdModel *followGdM;

@end


