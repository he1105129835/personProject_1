//
//  HNPMyPersonheaderCell.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/2.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNPMyPersonheaderCell;
@protocol HNPMyPersonBtnDelegate <NSObject>

//点击收藏
-(void)collectionBtnDidClick:(HNPMyPersonheaderCell *)headerCell;
//点击赞
-(void)zanBtnDidClick:(HNPMyPersonheaderCell *)headerCell;
//点击关注
-(void)followBtnDidClick:(HNPMyPersonheaderCell *)headerCell;
//点击约战
-(void)battleBtnDidClick:(HNPMyPersonheaderCell *)headerCell;

@end


@interface HNPMyPersonheaderCell : UITableViewCell

@property (nonatomic ,weak) id<HNPMyPersonBtnDelegate> delegate;

@end
