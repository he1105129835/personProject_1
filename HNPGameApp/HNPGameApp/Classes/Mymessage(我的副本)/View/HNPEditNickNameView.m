//
//  HNPEditNickNameView.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/10.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPEditNickNameView.h"

@interface HNPEditNickNameView ()

@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womenBtn;
@property (nonatomic,copy)NSString *sexLable;


@end

@implementation HNPEditNickNameView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.manBtn.selected = YES;
}

- (void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    frame.size.height = [UIScreen mainScreen].bounds.size.height;
    [super setFrame:frame];
}
- (IBAction)quxiaoBtn:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)quedingBtn:(id)sender {
    [MBProgressHUD showMessage:@"修改成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        if ([self.delegate respondsToSelector:@selector(quedingBtnDidClick:)]) {
            if (self.womenBtn.isSelected) {
                [self.delegate quedingBtnDidClick:@"女"];
            }else{
                [self.delegate quedingBtnDidClick:@"男"];
            }
        }
        if (self.womenBtn.isSelected) {
            self.sexLable = @"女";
        }else if (self.manBtn.isSelected){
            self.sexLable = @"男";
        }
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
        NSMutableDictionary *userPlist = [[[NSMutableDictionary alloc] initWithContentsOfFile:path] mutableCopy];
        [userPlist setObject:self.sexLable forKey:@"sex"];
        [userPlist writeToFile:path atomically:YES];
        appDelegate.mineUserInfoModel.sex = self.sexLable;
        [self removeFromSuperview];
    });
}

- (IBAction)manBtn:(id)sender {
    self.manBtn.selected = YES;
    self.womenBtn.selected = NO;
}
- (IBAction)womenBtn:(id)sender {
    self.womenBtn.selected = YES;
    self.manBtn.selected = NO;
}

@end
