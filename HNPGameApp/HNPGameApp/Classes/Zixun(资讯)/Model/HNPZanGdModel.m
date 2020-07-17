//
//  HNPZanGdModel.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/16.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPZanGdModel.h"

@implementation HNPZanGdModel

-(void)encodeWithCoder:(NSCoder *)coder{
    //归档属性
    [coder encodeObject:self.neirongImageView forKey:@"neirongImageView"];
    [coder encodeObject:self.neirongLable forKey:@"neirongLable"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.neirongImageView = [coder decodeObjectForKey:@"neirongImageView"];
        self.neirongLable = [coder decodeObjectForKey:@"neirongLable"];
    }
    return self;
}

@end
