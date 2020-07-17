//
//  HNPMyCollectionCell.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNPMyCollectionCell;
@protocol HNPQXCollectionBtnDelegate <NSObject>

//点击关注按钮
-(void)MyQxCollectionBtnDidClick:(HNPMyCollectionCell *)myCollectionCell;

@end

@interface HNPMyCollectionCell : UITableViewCell

@property (nonatomic ,weak) id<HNPQXCollectionBtnDelegate> delegate;
@property(nonatomic,strong)HNPDianJingModel *djModel;

@end
