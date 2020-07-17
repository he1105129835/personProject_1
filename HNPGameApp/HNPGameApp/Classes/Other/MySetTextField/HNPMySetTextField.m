//
//  HNPMySetTextField.m
//  HNPGameApp
//
//  Created by henanping on 2020/7/14.
//  Copyright © 2020 何南平. All rights reserved.
//

#import "HNPMySetTextField.h"

@interface HNPMySetTextField ()



@end

@implementation HNPMySetTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    UIDatePicker *pickV = [UIDatePicker new];
    pickV.datePickerMode = UIDatePickerModeDate;
    pickV.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [pickV addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    self.inputView = pickV;
}

-(void)dateChange:(UIDatePicker *)pickV{
    NSLog(@"%zd",self.text.length);
    NSDate *date = pickV.date;
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [fmt stringFromDate:date];
    self.text = dateString;
    NSLog(@"%zd",self.text.length);
}



@end
