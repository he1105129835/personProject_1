//
//  HNPZixunDetailsVC.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNPZixunModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HNPZixunDetailsVC : BaseViewController

@property(nonatomic,strong)HNPZixunModel *zixunDetailsM;
@property(nonatomic,assign)Boolean login;

@end
NS_ASSUME_NONNULL_END
