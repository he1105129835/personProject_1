//
//  HNPBattleTeamModel.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/15.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNPBattleTeamModel : NSObject<NSCoding>

@property (nonatomic,assign) NSInteger TeamTag;
@property (nonatomic,strong) NSString *battleTeamHead_1;
@property (nonatomic,strong) NSString *battleTeamHead_2;
@property (nonatomic,strong) NSString *battleTeamName_1;
@property (nonatomic,strong) NSString *battleTeamName_2;
@property (nonatomic,strong) NSString *fabuTime;
@property (nonatomic,strong) NSString *gameName;

@end

NS_ASSUME_NONNULL_END
