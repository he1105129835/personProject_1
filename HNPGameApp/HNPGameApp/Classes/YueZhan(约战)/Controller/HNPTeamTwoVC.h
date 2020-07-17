//
//  HNPTeamTwoVC.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/14.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNPPaimingListModel.h"

NS_ASSUME_NONNULL_BEGIN

@class HNPTeamTwoVC;
@protocol HNPTeamTwoVCReturnClickDelegate <NSObject>

-(void)returnDataTwoWhenClick:(HNPTeamTwoVC *)OneVC returnClick:(HNPPaimingListModel *)Model;

@end

@interface HNPTeamTwoVC : UIViewController

@property(nonatomic,assign)NSInteger TeamTag;
@property(weak,nonatomic)id <HNPTeamTwoVCReturnClickDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
