//
//  HNPFabuYuezhanVC.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/4.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPFabuYuezhanVC.h"

@interface HNPFabuYuezhanVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *boxBtn_1;
@property (weak, nonatomic) IBOutlet UIButton *boxBtn_2;
@property (weak, nonatomic) IBOutlet UIButton *boxBtn_3;
@property (weak, nonatomic) IBOutlet UIButton *preSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *preSelectBtn_1;
@property (weak, nonatomic) IBOutlet UIImageView *touxiang_1;
@property (weak, nonatomic) IBOutlet UIImageView *touxiang_2;
@property (weak, nonatomic) IBOutlet UIImageView *touxiang_3;
@property (weak, nonatomic) IBOutlet UILabel *teamLable_1;
@property (weak, nonatomic) IBOutlet UILabel *teamLable_2;
@property (weak, nonatomic) IBOutlet UILabel *teamLable_3;
@property (weak, nonatomic) IBOutlet UIImageView *tianjia_1;
@property (weak, nonatomic) IBOutlet UIImageView *tianjia_2;
@property (weak, nonatomic) IBOutlet UIImageView *tianjia_3;
@property (weak, nonatomic) IBOutlet UIButton *fabuBtn;
@property (weak, nonatomic) IBOutlet UITextField *guizeText_f;
@property (weak, nonatomic) IBOutlet UITextField *phoneText_f;
@property (weak, nonatomic) IBOutlet UITextField *emailText_f;
@property (weak, nonatomic) IBOutlet UITextField *messageText_f;


@end

@implementation HNPFabuYuezhanVC

BOOL flag = 0;

- (void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"发布约战";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self kongjianHidden];
    [self lijifabuBtn];
    [self textFMonitor];
}

//控件隐藏
-(void)kongjianHidden{
    self.imageViewHeight.constant = 0;
    self.boxBtn_1.hidden = YES;
    self.boxBtn_2.hidden = YES;
    self.boxBtn_3.hidden = YES;
    self.touxiang_1.hidden = YES;
    self.touxiang_2.hidden = YES;
    self.touxiang_3.hidden = YES;
    self.teamLable_1.hidden = YES;
    self.teamLable_2.hidden = YES;
    self.teamLable_3.hidden = YES;
    self.tianjia_1.hidden = YES;
    self.tianjia_2.hidden = YES;
    self.tianjia_3.hidden = YES;
    self.preSelectBtn.backgroundColor = UIColor.systemBlueColor;
    self.preSelectBtn_1.backgroundColor = UIColor.systemBlueColor;
}

//切换按钮状态
- (IBAction)menuClick:(UIButton *)btn {
    self.preSelectBtn.selected = NO;
    self.preSelectBtn.backgroundColor = UIColor.clearColor;
    [btn setBackgroundColor:[UIColor systemBlueColor]];
    btn.selected = YES;
    self.preSelectBtn = btn;
}
- (IBAction)saizhiBtn:(UIButton *)btn {
    self.preSelectBtn_1.selected = NO;
    self.preSelectBtn_1.backgroundColor = UIColor.systemGray6Color;
    [btn setBackgroundColor:[UIColor systemBlueColor]];
    btn.selected = YES;
    self.preSelectBtn_1 = btn;
}


#pragma mark - 方法

//点击屏幕其它地方关闭键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//点击添加战队按钮进行控件的显示与隐藏
- (IBAction)addTeamBtn:(id)sender {
    if (flag == 0) {
        self.imageViewHeight.constant = 130;
        self.boxBtn_1.hidden = NO;
        self.boxBtn_2.hidden = NO;
        self.boxBtn_3.hidden = NO;
        self.touxiang_1.hidden = NO;
        self.touxiang_2.hidden = NO;
        self.touxiang_3.hidden = NO;
        self.teamLable_1.hidden = NO;
        self.teamLable_2.hidden = NO;
        self.teamLable_3.hidden = NO;
        self.tianjia_1.hidden = NO;
        self.tianjia_2.hidden = NO;
        self.tianjia_3.hidden = NO;
        flag = 1;
    }
    else {
        self.imageViewHeight.constant = 0;
        self.boxBtn_1.hidden = YES;
        self.boxBtn_2.hidden = YES;
        self.boxBtn_3.hidden = YES;
        self.touxiang_1.hidden = YES;
        self.touxiang_2.hidden = YES;
        self.touxiang_3.hidden = YES;
        self.teamLable_1.hidden = YES;
        self.teamLable_2.hidden = YES;
        self.teamLable_3.hidden = YES;
        self.tianjia_1.hidden = YES;
        self.tianjia_2.hidden = YES;
        self.tianjia_3.hidden = YES;
        flag = 0;
    }
    
}

/**为输入框添加监听*/
-(void)textFMonitor{
    [self.guizeText_f addTarget:self action:@selector(lijifabuBtn) forControlEvents:UIControlEventEditingChanged];
    [self.phoneText_f addTarget:self action:@selector(lijifabuBtn) forControlEvents:UIControlEventEditingChanged];
    [self.emailText_f addTarget:self action:@selector(lijifabuBtn) forControlEvents:UIControlEventEditingChanged];
    [self.messageText_f addTarget:self action:@selector(lijifabuBtn) forControlEvents:UIControlEventEditingChanged];
}
//立即发布按钮能否点击判断
-(void)lijifabuBtn{
    if (self.guizeText_f.text.length >= 1 && self.phoneText_f.text.length >= 1 && self.emailText_f.text.length >= 1 &&self.messageText_f.text.length >= 1) {
        self.fabuBtn.enabled = YES;
    }else{
        self.fabuBtn.enabled = NO;
    }
}


@end
