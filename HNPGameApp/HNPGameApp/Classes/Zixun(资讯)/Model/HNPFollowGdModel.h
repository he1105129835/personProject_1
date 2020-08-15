//
//  HNPFollowGdModel.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/16.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNPFollowGdModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *userHead;
@property (nonatomic,strong) NSString *userNickname;
@property (nonatomic,assign) BOOL isFollow;

@end

NS_ASSUME_NONNULL_END
