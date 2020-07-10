//
//  HNPMyBattleCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMyBattleCell.h"

@interface HNPMyBattleCell ()

@property (weak, nonatomic) IBOutlet UIView *zhankaiView;




@end

@implementation HNPMyBattleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)zhankaiBtn:(id)sender {
    self.zhankaiView.hidden = !self.zhankaiView.hidden;
}


- (IBAction)deleteBtn:(id)sender {
    self.zhankaiView.hidden = !self.zhankaiView.hidden;
    if ([self.delegate respondsToSelector:@selector(MyBattleDeleteBtnDidClick:)]) {
        [self.delegate MyBattleDeleteBtnDidClick:self];
    }
}



@end
