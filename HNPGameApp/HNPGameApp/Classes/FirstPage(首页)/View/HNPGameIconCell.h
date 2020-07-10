//
//  HNPGameIconCell.h
//  HNPGameApp
//
//  Created by henanping on 2020/6/29.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNPGameIconCell;
@protocol HNPGameIconBtnDelegate <NSObject>

//点击收藏
-(void)WZBtnDidClick:(HNPGameIconCell *)IconCell;
//点击赞
-(void)LOLBtnDidClick:(HNPGameIconCell *)IconCell;
//点击关注
-(void)SWBtnDidClick:(HNPGameIconCell *)IconCell;
//点击约战
-(void)PUBGBtnDidClick:(HNPGameIconCell *)IconCell;

@end


@interface HNPGameIconCell : UITableViewCell

@property (nonatomic ,weak) id<HNPGameIconBtnDelegate> delegate;

@end
