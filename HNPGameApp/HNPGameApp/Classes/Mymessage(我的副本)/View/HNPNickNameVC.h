//
//  HNPNickNameVC.h
//  HNPGameApp
//
//  Created by henanping on 2020/7/10.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HNPEditNickNameDelegate <NSObject>

@optional
-(void)EditSureBtnDidClick:(NSString *)setNickName;

@end


@interface HNPNickNameVC : UIView

@property (nonatomic ,weak) id<HNPEditNickNameDelegate> delegate;

@end
