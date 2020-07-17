//
//  HNPFollowGdModelArray.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/16.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPFollowGdModelArray.h"

@implementation HNPFollowGdModelArray

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.followGdArray forKey:@"followGdArray"];
}

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        //解档
        self.followGdArray = [coder decodeObjectForKey:@"followGdArray"];
    }
    return self;
}

@end
