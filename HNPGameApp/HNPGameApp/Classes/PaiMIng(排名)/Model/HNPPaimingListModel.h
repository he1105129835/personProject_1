//
//  HNPPaimingListModel.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/6.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNPPaimingListModel : NSObject

@property(nonatomic,copy)NSString *iconName;
@property(nonatomic,copy)NSNumber *lose;
@property(nonatomic,copy)NSNumber *score;
@property(nonatomic,copy)NSString *teamName;
@property(nonatomic,copy)NSNumber *win;
@property(nonatomic,copy)NSNumber *shenglv;

@end

NS_ASSUME_NONNULL_END
