//
//  ChanceRoleView.m
//  demo
//
//  Created by wangdaoqinqiyi on 15/9/10.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import "ChanceRoleView.h"

@implementation ChanceRoleView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        imageView=[[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        imageView.image=[UIImage imageNamed:@"common_background.png"];
        [self addSubview:imageView];
        
        studentButton=[UIButton buttonWithType:UIButtonTypeCustom];
        studentButton.backgroundColor=[UIColor whiteColor];
        studentButton.layer.masksToBounds=YES;
        studentButton.layer.cornerRadius=145/2;
        [studentButton setTitle:@"我是学生" forState:UIControlStateNormal];
        [studentButton setTitleColor:[UIColor colorWithRed:75.0/255.0 green:189.0/255.0 blue:240.0/255.0 alpha:1] forState:UIControlStateNormal];
        [studentButton addTarget:self action:@selector(studentPress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:studentButton];
        
        teacherButton=[UIButton buttonWithType:UIButtonTypeCustom];
        teacherButton.layer.masksToBounds=YES;
        teacherButton.layer.cornerRadius=145/2;
        [teacherButton setTitle:@"我是老师" forState:UIControlStateNormal];
        [teacherButton setTitleColor:[UIColor colorWithRed:75.0/255.0 green:189.0/255.0 blue:240.0/255.0 alpha:1] forState:UIControlStateNormal];
        teacherButton.backgroundColor=[UIColor whiteColor];
        [teacherButton addTarget:self action:@selector(teacherPress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:teacherButton];
        
        
    }
    return self;
}
-(void)studentPress
{
    self.studentHandler(self);
}
-(void)teacherPress
{
    self.teacherHandler(self);
}
- (void)drawRect:(CGRect)rect {
    studentButton.frame=CGRectMake((rect.size.width-145)/2, (rect.size.height-145*2)/3, 145, 145);
    teacherButton.frame=CGRectMake((rect.size.width-145)/2, (rect.size.height-145*2)/3+200, 145, 145);
}


@end
