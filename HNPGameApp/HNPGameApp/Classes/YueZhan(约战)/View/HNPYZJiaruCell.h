//
//  HNPYZJiaruCell.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/2.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNPYZJiaruCell;
@protocol HNPJubaoBtnDelegate <NSObject>

-(void)jubaoBtnDidClick:(HNPYZJiaruCell *)jiaruCell;

@end


@interface HNPYZJiaruCell : UITableViewCell

@property (nonatomic ,weak) id<HNPJubaoBtnDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *jiaruImageView_1;
@property (weak, nonatomic) IBOutlet UIImageView *jiaruImageView_2;
@property (weak, nonatomic) IBOutlet UILabel *jiaruNameLable_1;
@property (weak, nonatomic) IBOutlet UILabel *jiaruNameLable_2;

@end

