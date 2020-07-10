//
//  HNPMyPersonheaderCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/2.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMyPersonheaderCell.h"

@interface HNPMyPersonheaderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *HeaderImageView;


@end

@implementation HNPMyPersonheaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HeaderImageView.layer.cornerRadius = 30;
}

- (IBAction)collectionBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(collectionBtnDidClick:)]) {
        [self.delegate collectionBtnDidClick:self];
    }
}
- (IBAction)zanBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(zanBtnDidClick:)]) {
        [self.delegate zanBtnDidClick:self];
    }
}
- (IBAction)followBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(followBtnDidClick:)]) {
        [self.delegate followBtnDidClick:self];
    }
}
- (IBAction)battleBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(battleBtnDidClick:)]) {
        [self.delegate battleBtnDidClick:self];
    }
}



@end
