//
//  HNPEditNickNameView.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/10.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HNPquedingBtnDelegate <NSObject>

@optional
-(void)quedingBtnDidClick:(NSString *)setSex;

@end


@interface HNPEditNickNameView : UIView

@property (nonatomic ,weak) id<HNPquedingBtnDelegate> delegate;

@end
