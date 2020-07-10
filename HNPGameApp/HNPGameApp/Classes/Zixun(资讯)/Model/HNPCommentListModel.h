//
//  HNPCommentListModel.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/7.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNPCommentListModel : NSObject

@property(nonatomic,strong)NSString *pageSize;
@property(nonatomic,strong)NSString *totalPage;
@property(nonatomic,strong)NSString *totalSize;

@end

NS_ASSUME_NONNULL_END
