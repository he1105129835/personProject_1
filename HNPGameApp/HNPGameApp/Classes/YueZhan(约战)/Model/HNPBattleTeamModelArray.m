//
//  HNPBattleTeamModelArray.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/15.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPBattleTeamModelArray.h"

@implementation HNPBattleTeamModelArray

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.modelArray forKey:@"modelArray"];
}

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        //解档
        self.modelArray = [coder decodeObjectForKey:@"modelArray"];
    }
    return self;
}

@end
