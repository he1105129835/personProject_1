//
//  HNPPersonModel.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/7.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPPersonModel.h"

@implementation HNPPersonModel

+(instancetype)HNPPersonModelWithDict:(NSDictionary *)dict{
    
    HNPPersonModel *model = [[HNPPersonModel alloc] init];
    
    model.fansCount = dict[@"fansCount"];
    model.followCount = dict[@"followCount"];
    model.head = dict[@"head"];
    model.nickName = dict[@"nickName"];
    model.signature = dict[@"signature"];
    model.talkCount = dict[@"talkCount"];
    model.userId = dict[@"id"];
    model.sex = dict[@"sex"];
    model.collectionCount = dict[@"collectionCount"];
    
    return model;
    
}

@end
