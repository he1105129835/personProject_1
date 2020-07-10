//
//  HNPXuanzePlaceCell.h
//  HNPGameApp
//
//  Created by henanping on 2020/6/29.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNPXuanzePlaceCell;
@protocol HNPHomeXuanzeBtnDetegate <NSObject>

-(void)HomeXuzanzeFujinBtnDidClick:(HNPXuanzePlaceCell *)HomeXuanzeCell;
-(void)HomeXuzanzeHotBtnDidClick:(HNPXuanzePlaceCell *)HomeXuanzeCell;

@end

@interface HNPXuanzePlaceCell : UITableViewCell

@property(nonatomic,weak)id<HNPHomeXuanzeBtnDetegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *fujinBtn;
@property (weak, nonatomic) IBOutlet UIButton *hotBtn;

@end



