//
//  HNPTabBar.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/16.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPTabBar.h"

@interface HNPTabBar ()

@property (strong, nonatomic) UIButton *centerTabBarBtn;


@end

@implementation HNPTabBar

#define ScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight  ([UIScreen mainScreen].bounds.size.height)

#define iPhoneX ((ScreenHeight == 812.0 || ScreenHeight == 896.0) ? YES : NO)
#define kBottomSafeSpace (iPhoneX ? 34.0 : 0.0)

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initView];
    }
    return self;
}

- (void)initView{

    // 加载图片
    UIImage *image = [UIImage imageNamed:@"tab"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(-8, - 25, ScreenWidth + 20, 89);
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    UIView *backView = [[UIView alloc] init];
    backView.frame = CGRectMake(-10, 15, imageView.frame.size.width, 120);
    backView.backgroundColor = UIColor.whiteColor;
    [imageView addSubview:backView];

    [self addSubview:imageView];
    
}



@end
