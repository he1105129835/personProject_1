//
//  HNPZixunModel.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/6.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNPZixunUserModel.h"
#import "HNPCommentListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HNPZixunModel : NSObject

@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *browserCount;
@property(nonatomic,strong)NSString *commentCount;
@property(nonatomic,strong)NSString *followCount;
@property(nonatomic,strong)NSString *publishTime;
@property(nonatomic,strong)NSString *talkId;
@property(nonatomic,strong)NSString *id;
@property (assign, nonatomic) BOOL isFollow;
@property(nonatomic, strong)NSMutableArray *list;
@property(nonatomic,strong)HNPZixunUserModel *user;

@end

NS_ASSUME_NONNULL_END
