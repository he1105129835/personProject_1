//
//  HNPYZJiaruCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/2.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPYZJiaruCell.h"

@interface HNPYZJiaruCell ()

@property (weak, nonatomic) IBOutlet UIImageView *blueImageView;


@end

@implementation HNPYZJiaruCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.blueImageView.layer.cornerRadius = 10;
    
}

- (IBAction)jubaoBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(jubaoBtnDidClick:)]) {
        [self.delegate jubaoBtnDidClick:self];
    }
}



@end
