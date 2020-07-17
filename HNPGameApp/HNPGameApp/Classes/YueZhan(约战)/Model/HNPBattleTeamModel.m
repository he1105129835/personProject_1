//
//  HNPBattleTeamModel.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/15.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPBattleTeamModel.h"

@implementation HNPBattleTeamModel

-(void)encodeWithCoder:(NSCoder *)coder{
    //归档属性
    [coder encodeObject:self.battleTeamHead_1 forKey:@"battleTeamHead_1"];
    [coder encodeObject:self.battleTeamHead_2 forKey:@"battleTeamHead_2"];
    [coder encodeObject:self.battleTeamName_1 forKey:@"battleTeamName_1"];
    [coder encodeObject:self.battleTeamName_2 forKey:@"battleTeamName_2"];
    [coder encodeObject:self.fabuTime forKey:@"fabuTime"];
    [coder encodeObject:self.gameName forKey:@"gameName"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.battleTeamHead_1 = [coder decodeObjectForKey:@"battleTeamHead_1"];
        self.battleTeamHead_2 = [coder decodeObjectForKey:@"battleTeamHead_2"];
        self.battleTeamName_1 = [coder decodeObjectForKey:@"battleTeamName_1"];
        self.battleTeamName_2 = [coder decodeObjectForKey:@"battleTeamName_2"];
        self.fabuTime = [coder decodeObjectForKey:@"fabuTime"];
        self.gameName = [coder decodeObjectForKey:@"gameName"];
    }
    return self;
}

@end
