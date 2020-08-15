//
//  HNPFollowGdModel.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/16.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPFollowGdModel.h"

@implementation HNPFollowGdModel

-(void)encodeWithCoder:(NSCoder *)coder{
    //归档属性
    [coder encodeObject:self.userHead forKey:@"userHead"];
    [coder encodeObject:self.userNickname forKey:@"userNickname"];
    [coder encodeBool:self.isFollow forKey:@"isFollow"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.userHead = [coder decodeObjectForKey:@"userHead"];
        self.userNickname = [coder decodeObjectForKey:@"userNickname"];
        self.userNickname = [coder decodeObjectForKey:@"isFollow"];
    }
    return self;
}

@end
