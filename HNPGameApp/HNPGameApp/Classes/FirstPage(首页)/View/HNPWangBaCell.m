//
//  HNPWangBaCell.m
//  HNPGameApp
//
//  Created by henanping on 2020/6/29.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPWangBaCell.h"
#import "UIImageView+WebCache.h"

@interface HNPWangBaCell ()

@property (weak, nonatomic) IBOutlet UIImageView *wangbaImageView;
@property (weak, nonatomic) IBOutlet UILabel *wangbaName;
@property (weak, nonatomic) IBOutlet UILabel *juliLable;
@property (weak, nonatomic) IBOutlet UILabel *wangbaAddress;

@property (weak, nonatomic) IBOutlet UIImageView *xingxing_1;
@property (weak, nonatomic) IBOutlet UIImageView *xingxing_2;
@property (weak, nonatomic) IBOutlet UIImageView *xingxing_3;
@property (weak, nonatomic) IBOutlet UIImageView *xingxing_4;
@property (weak, nonatomic) IBOutlet UIImageView *xingxing_5;

@property(strong,nonatomic)NSMutableDictionary *images;


@end

@implementation HNPWangBaCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setDJModel:(HNPDianJingModel *)DJModel{
    _DJModel = DJModel;
    self.wangbaName.text = DJModel.name;
    self.wangbaAddress.text = DJModel.address;
    
//    [self.wangbaImageView sd_setImageWithURL:[NSURL URLWithString:DJModel.pic] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    NSURL *wangbaImageURL = [NSURL URLWithString:DJModel.pic];
    if(wangbaImageURL){
        [self.wangbaImageView sd_setImageWithURL:wangbaImageURL];
    }else{
        NSData *imageData = [NSData dataWithContentsOfURL:wangbaImageURL];
        [self.wangbaImageView sd_setImageWithURL:wangbaImageURL];
        //下载完图片之后保存到字典中
        [self.images setObject:imageData forKey:DJModel.pic];
    }
    
    switch (DJModel.star.intValue) {
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
