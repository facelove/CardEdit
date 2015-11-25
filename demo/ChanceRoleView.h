//
//  ChanceRoleView.h
//  demo
//
//  Created by wangdaoqinqiyi on 15/9/10.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChanceRoleView;
typedef void (^ StudentHandler)(ChanceRoleView*view);

typedef void (^ TeacherHandler)(ChanceRoleView*view);

@interface ChanceRoleView : UIView
{
    UIButton *studentButton;
    UIButton *teacherButton;
    UIImageView* imageView;
}
@property(nonatomic,strong)StudentHandler studentHandler;
@property(nonatomic,strong)TeacherHandler teacherHandler;
@end
