//
//  HNPPersonModel.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/7.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HNPPersonModel : NSObject

@property(nonatomic,copy)NSString *head;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *signature;
@property(nonatomic,copy)NSString *collectionCount;
@property(nonatomic,copy)NSString *fansCount;
@property(nonatomic,copy)NSString *followCount;
@property(nonatomic,copy)NSString *talkCount;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *sex;

+(instancetype)HNPPersonModelWithDict:(NSDictionary *)dict;

@end

