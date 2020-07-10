//
//  HNPZixunModel.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/6.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPZixunModel.h"
#import "MJExtension.h"

@implementation HNPZixunModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"talkId" : @"id"
    };
}

@end
