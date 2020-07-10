//
//  HNPXuanzePlaceCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/6/29.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPXuanzePlaceCell.h"

@interface HNPXuanzePlaceCell ()



@end

@implementation HNPXuanzePlaceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.fujinBtn.selected = YES;
}


- (IBAction)fujinBtnClick:(UIButton *)sender {
    self.fujinBtn.selected = YES;
    self.hotBtn.selected = NO;
    if ([self.delegate respondsToSelector:@selector(HomeXuzanzeFujinBtnDidClick:)]) {
        [self.delegate HomeXuzanzeFujinBtnDidClick:self];
    }
}
- (IBAction)hotBtnClick:(UIButton *)sender {
    self.hotBtn.selected = YES;
    self.fujinBtn.selected = NO;
    if ([self.delegate respondsToSelector:@selector(HomeXuzanzeHotBtnDidClick:)]) {
        [self.delegate HomeXuzanzeHotBtnDidClick:self];
    }
}




@end
