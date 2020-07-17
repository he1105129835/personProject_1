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
@property (weak, nonatomic) IBOutlet UILabel *collentionCount;
@property (weak, nonatomic) IBOutlet UILabel *zanCount;
@property (weak, nonatomic) IBOutlet UILabel *followCount;
@property (weak, nonatomic) IBOutlet UILabel *battleCount;


@end

@implementation HNPMyPersonheaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HeaderImageView.layer.cornerRadius = 30;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selector) name:@"editHeader" object:nil];
}



-(void)selector{
    [self.HeaderImageView sd_setImageWithURL:[NSURL URLWithString:self.personMdoel.head] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    
}

- (void)setPersonMdoel:(HNPPersonModel *)personMdoel{
    _personMdoel = personMdoel;
    [self.HeaderImageView sd_setImageWithURL:[NSURL URLWithString:self.personMdoel.head] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
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
