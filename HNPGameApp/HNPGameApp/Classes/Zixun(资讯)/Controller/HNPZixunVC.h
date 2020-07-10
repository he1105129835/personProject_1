//
//  HNPZixunVC.h
//  HNPGameApp
//
//  Created by henanping on 2020/6/29.
//  Copyright © 2020 何南平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FSScrollContentView.h>

NS_ASSUME_NONNULL_BEGIN

@interface HNPZixunVC : UIViewController

@property (nonatomic ,strong)FSPageContentView *pageContentView;
//顶部控制器的标题
@property (nonatomic ,strong)FSSegmentTitleView *titleView;

@property(nonatomic,assign)Boolean flag;

@end

NS_ASSUME_NONNULL_END
