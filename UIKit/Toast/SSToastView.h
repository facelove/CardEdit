//
//  WDQToastView.h
//  QiYiVideo
//
//  Created by wangdaoqin on 15/6/1.
//  Copyright (c) 2015年 QiYi. All rights reserved.
//

/*
 使用说明：
 (1)两种toast ：纯文字toast和icon＋文字toast
    纯文本toast使用范围：可以自定义起点origin，如果是CGPointZero 则是view居中
                      自定义文案对齐方式 如果文案中有“\n”请选用中间对齐方式
    icon＋文字：仅限制 loading，wait,upload三种展现，
 (2)toast自适配所有机型：4，5，6，6P,ipad
 (3)
 */



#import <UIKit/UIKit.h>

typedef enum showType{
    toast_wait,
    toast_upload,
    toast_loading,
    /*
     暂时只有上边三种
    toast_fail,
    toast_collect,
    toast_uncollect,
    toast_up,
    toast_down,
    toast_love,
    toast_shake,
    toast_sucess,
     */
    
}TosatType;

@interface SSToastView : UIView
/**
 *调用icon+文字类型 备注：“仅居中显示，需要手动显示和消失”
 *@param type：loading，upload，wait 三种中的一种
 *@param message：文字
 *@param superViewA：toast的superView   居于view中央。
 
 显示：+(void)showToastWithType:(TosatType)type message:(NSString*)message superViewA:(UIView*)superViewA；
 消失：+(void)hidenToastWithType:(UIView*)superViewA;
 */
+(void)showToastWithType:(TosatType)type message:(NSString*)message superView:(UIView*)superView;
/*
 *隐藏icon＋文字 toastView
 */
+(void)hidenToastWithType:(UIView*)superView;
/**
 *调用纯文字类型   位置由bottom参数决定

 *@param message：文字
 *@param superView：toast的superView   。
 *@param bottom：toast相对于supreview底部的距离
 *@param textAlignment：适用于换行的，第二行是居中还是居左 播放器一般为NSTextAlignmentLeft。
 */

//通用显示，根据产品定义的default位置  适配机型中偏下
+(void)showToastWithMessage:(NSString *)message superView:(UIView *)superView;
//自定义位置显示，此多为播放器调用，可以自定义离底部的距离，左右居中
+(void)showToastWithMessage:(NSString*)message superView:(UIView*)superView bottom:(float)bottom textAlignment:(NSTextAlignment)textAlignment autoHide:(BOOL)hide;
+(BOOL)isHasToastView:(UIView*)superView;//是否存在toast
@end

