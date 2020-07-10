//
//  HNPziXunCell.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/1.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNPZixunModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HNPziXunCell : UITableViewCell

@property(nonatomic,strong)HNPZixunModel *zixunMdoel;
@property (weak, nonatomic) IBOutlet UILabel *zixunFabuNameLable;

@end

NS_ASSUME_NONNULL_END
