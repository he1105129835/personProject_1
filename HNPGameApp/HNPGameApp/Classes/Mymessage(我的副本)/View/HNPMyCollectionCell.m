//
//  HNPMyCollectionCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/3.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMyCollectionCell.h"

@interface HNPMyCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView;
@property (weak, nonatomic) IBOutlet UILabel *collectionName;
@property (weak, nonatomic) IBOutlet UIButton *collectionfollow;
@property (weak, nonatomic) IBOutlet UILabel *collectionAddress;
@property (weak, nonatomic) IBOutlet UIImageView *xingxing_1;
@property (weak, nonatomic) IBOutlet UIImageView *xingxing_2;
@property (weak, nonatomic) IBOutlet UIImageView *xingxing_3;
@property (weak, nonatomic) IBOutlet UIImageView *xingxing_4;
@property (weak, nonatomic) IBOutlet UIImageView *xingxing_5;


@end

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

- (void)setDjModel:(HNPDianJingModel *)djModel{
    _djModel = djModel;
    [self.collectionImageView sd_setImageWithURL:[NSURL URLWithString:self.djModel.pic] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    self.collectionName.text = self.djModel.name;
    self.collectionAddress.text = self.djModel.address;
    switch (self.djModel.star.intValue) {
        case 0:
            break;
        case 1:
            _xingxing_1.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_2.image = [UIImage imageNamed:@"pic_kongxing"];
            _xingxing_3.image = [UIImage imageNamed:@"pic_kongxing"];
            _xingxing_4.image = [UIImage imageNamed:@"pic_kongxing"];
            _xingxing_5.image = [UIImage imageNamed:@"pic_kongxing"];
            break;
        case 2:
            _xingxing_1.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_2.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_3.image = [UIImage imageNamed:@"pic_kongxing"];
            _xingxing_4.image = [UIImage imageNamed:@"pic_kongxing"];
            _xingxing_5.image = [UIImage imageNamed:@"pic_kongxing"];
            break;
        case 3:
            _xingxing_1.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_2.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_3.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_4.image = [UIImage imageNamed:@"pic_kongxing"];
            _xingxing_5.image = [UIImage imageNamed:@"pic_kongxing"];
            break;
        case 4:
            _xingxing_1.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_2.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_3.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_4.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_5.image = [UIImage imageNamed:@"pic_kongxing"];
            break;
            case 5:
            _xingxing_1.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_2.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_3.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_4.image = [UIImage imageNamed:@"pic_xing"];
            _xingxing_5.image = [UIImage imageNamed:@"pic_xing"];
            break;
        default:
            break;
    }
    
}

@end
