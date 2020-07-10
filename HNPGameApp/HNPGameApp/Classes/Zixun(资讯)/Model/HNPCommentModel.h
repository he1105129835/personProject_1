//
//  HNPCommentModel.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/6.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HNPZixunModel,HNPZixunUserModel;
@interface HNPCommentModel : NSObject

//@property (nonatomic, strong)HNPZixunModel *talkId;
/**用户信息模型*/
@property (strong, nonatomic)HNPZixunUserModel *commentUserModel;

@end

NS_ASSUME_NONNULL_END
