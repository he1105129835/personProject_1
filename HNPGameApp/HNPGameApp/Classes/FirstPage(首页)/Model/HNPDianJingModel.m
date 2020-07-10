//
//  HNPDianJingModel.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/4.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPDianJingModel.h"
#import "MJExtension.h"

@implementation HNPDianJingModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
        @"userid" : @"id"
    };
}

@end
