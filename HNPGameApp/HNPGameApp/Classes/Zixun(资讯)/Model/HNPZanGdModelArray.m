//
//  HNPZanGdModelArray.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/16.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPZanGdModelArray.h"

@implementation HNPZanGdModelArray

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.zanGdArray forKey:@"zanGdArray"];
}

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        //解档
        self.zanGdArray = [coder decodeObjectForKey:@"zanGdArray"];
    }
    return self;
}

@end
