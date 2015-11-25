//
//  CardDataObj.h
//  demo
//
//  Created by 王道钦 on 15/9/26.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardDataObj : NSObject
@property(nonatomic,strong)NSString*title;   //data3类型的标题：如焦点图类型
@property(nonatomic,strong)NSString*descriptions;  //data3类型的描述：如焦点图详情
@property(nonatomic,strong)NSString*imgURL;        //img地址
@property(nonatomic,assign)NSString*openType;       //打开类型
@property(nonatomic,strong)NSString*superScript;//角标
@property(nonatomic,strong)NSString*subject;//科目
@property(nonatomic,strong)NSString*cocoaType;//辅导类型
@property(nonatomic,strong)NSString*openpid;//发布单ID
@property(nonatomic,strong)NSString*openurl;//打开URL
@property(nonatomic,strong)NSString*openview;//跳转View
@property(nonatomic,strong)NSString*tuid;//老师id
@property(nonatomic,strong)NSString*suid;//学生id
@property(nonatomic,strong)NSString*guid;//机构id
@property(nonatomic,strong)NSString*latitude;//经度
@property(nonatomic,strong)NSString*longitude;//纬度
+(CardDataObj*)fillDataWithRunTime:(NSDictionary*)dic;
@end
