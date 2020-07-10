//
//  HNPGameIconCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/6/29.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPGameIconCell.h"

@implementation HNPGameIconCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)wzBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(WZBtnDidClick:)]) {
        [self.delegate WZBtnDidClick:self];
    }
}
- (IBAction)lolBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(LOLBtnDidClick:)]) {
        [self.delegate LOLBtnDidClick:self];
    }
}
- (IBAction)swBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SWBtnDidClick:)]) {
        [self.delegate SWBtnDidClick:self];
    }
}
- (IBAction)pubgBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(PUBGBtnDidClick:)]) {
        [self.delegate PUBGBtnDidClick:self];
    }
}


@end
