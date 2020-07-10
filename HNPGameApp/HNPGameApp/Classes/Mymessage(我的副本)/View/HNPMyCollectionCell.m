//
//  HNPMyCollectionCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMyCollectionCell.h"

@implementation HNPMyCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)QxCollectionBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MyQxCollectionBtnDidClick:)]) {
        [self.delegate MyQxCollectionBtnDidClick:self];
    }
}

@end
