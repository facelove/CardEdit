//
//  WDQToastView.m
//  QiYiVideo
//
//  Created by wangdaoqin on 15/6/1.
//  Copyright (c) 2015年 QiYi. All rights reserved.
//

#import "SSToastView.h"
#import <QuartzCore/QuartzCore.h>


#define LOW_THAN_IOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0))



#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define WDQiphone4()    ([UIScreen mainScreen].bounds.size.width ==320 && [UIScreen mainScreen].bounds.size.height == 480)

#define WDQiphone6()    ([UIScreen mainScreen].bounds.size.width > 320 && [UIScreen mainScreen].bounds.size.width <= 375)
#define WDQiphone6Plus()    ([UIScreen mainScreen].bounds.size.width > 375)

#define QDQiphone5() ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#define getoffset(x4,x5,x6,x6p,xipad) (isPad?xipad:(WDQiphone6Plus()?x6p:\
((WDQiphone6()?x6:\
(QDQiphone5()?x5:x4)\
))\
)\
)

#define messageWith getoffset(200,200,200,225,290)  //15个字的长度


#define messagefont getoffset(13,13,13,15,19)


#define iphone6PlusFrame   CGRectMake(0, 0, 105, 105)

#define iphone6Frame   CGRectMake(0, 0, 84, 84)

#define iphone5Frame   CGRectMake(0, 0, 70, 70)

#define ipadFrame   CGRectMake(0, 0, 150, 150)

#define toastFrame  getoffset(iphone5Frame,iphone5Frame,iphone6Frame,iphone6PlusFrame,ipadFrame)  //15个字的长度

#define kToastColor (isPad?(0x70/255.0):0.0f)
#define kToastAlpha (isPad?0.94:0.74)

static const CGFloat CSToastFadeDuration        = 0.2;

@implementation NSObject (PerformBlockAfterDelay)

//+ (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
//    block = [block copy];
//    [self performSelector:@selector(fireBlockAfterDelay:) withObject:block afterDelay:delay];
//}

+ (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}

@end

@implementation SSToastView

/*
 (1)icon＋文字  居中调用
    应用于wait,upload,loading,需要手动消失
*/

+(void)showToastWithType:(TosatType)type message:(NSString*)message superView:(UIView*)superView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        {//在显示新的toast前，先检查是否存旧的
            [[self class] hidenToastWithType:superView];
        }
        
        UIView *toastView=[[self class] getToastViewWithType:type message:message bounds:superView.bounds];
        toastView.tag=1234567;
        [superView addSubview:toastView];
    });
    
}
+(void)hidenToastWithType:(UIView*)superView
{
    UIView *toastView=[superView viewWithTag:1234567];
    if (toastView)
    {
        [toastView.layer removeAllAnimations];
        [toastView removeFromSuperview];
    }
}

/*
 (2)纯文字 位置随意设定
 应用于非（wait,upload,loading）,自动消失
 bottom：toast的origin  如果为CGPointZero 则居中
 自定义
 */
+(void)showToastWithMessage:(NSString *)message superView:(UIView *)superView
{
    dispatch_async(dispatch_get_main_queue(), ^{
    if (isPad)
    {
        [[self class] showToastWithMessage:message superView:superView bottom:150 textAlignment:NSTextAlignmentCenter autoHide:YES];
    }
    else if(WDQiphone6Plus())
    {
        [[self class] showToastWithMessage:message superView:superView bottom:220/3 textAlignment:NSTextAlignmentCenter autoHide:YES];
    }
    else
    {
        [[self class] showToastWithMessage:message superView:superView bottom:110/2 textAlignment:NSTextAlignmentCenter autoHide:YES];
    }
        });
        
}
+(void)showToastWithMessage:(NSString*)message superView:(UIView*)superView bottom:(float)bottom textAlignment:(NSTextAlignment)textAlignment autoHide:(BOOL)hide

{//自定义设置位置

    {//如果上次不自动隐藏 ，那么直接除去 上次的。
        [[self class] hidenToastWithType:superView];
    }
    UIView *toastView=[[self class] getToastViewWithMessage:message textAlignment:textAlignment];
    toastView.center=CGPointMake(gw(superView)/2, gh(superView)-bottom-gh(toastView)/2);
    toastView.tag=1234567;
    [superView addSubview:toastView];
    
    [UIView animateWithDuration:CSToastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toastView.alpha = 1.0;
                     } completion:^(BOOL finished){
                         [UIView animateWithDuration:CSToastFadeDuration
                                               delay:1.5
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              toastView.alpha = 0.0;
                                          } completion:^(BOOL finished) {
                                              if (hide) {
                                                  [toastView.layer removeAllAnimations];
                                                  [toastView removeFromSuperview];
                                              }
                                          }];
                     }];
}

+(UIView*)getToastViewWithMessage:(NSString*)message textAlignment:(NSTextAlignment)textAlignment
{
    NSString* string=nil;
#if DEBUG
    string=[NSString stringWithFormat:@"%@-Debug",message];
#else
    string=[NSString stringWithFormat:@"%@",message];
    
#endif
    
    float spaceX=isPad?35:(WDQiphone6Plus()?23:15);
    
    CGSize size =[string boundingRectWithSize:CGSizeMake(messageWith , messagefont*2+10) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:messagefont]} context:nil].size;
    
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(spaceX, messagefont*0.8, size.width, size.height)] ;
    lable.backgroundColor=[UIColor clearColor];
    lable.textColor=[UIColor whiteColor];
    lable.textAlignment=textAlignment;
    lable.font=[UIFont systemFontOfSize:messagefont];
    lable.numberOfLines=0;
    lable.text=string;
    [lable textRectForBounds:CGRectMake(0, 0, size.width, size.height) limitedToNumberOfLines:2];
    
    
    UIView *bg=[[UIView alloc] initWithFrame:CGRectMake(0, 0, lable.frame.size.width+spaceX*2,lable.frame.size.height+messagefont*1.6)] ;
    bg.layer.cornerRadius=4;
    //bg.alpha=0.74;
    bg.layer.masksToBounds=YES;
    bg.backgroundColor=[UIColor colorWithWhite:kToastColor alpha:kToastAlpha];
    [bg addSubview:lable];
    
    {//最低宽度适配和圆角适配
        float miniWidth=0;
        if (isPad)
        {
            miniWidth=180;
            bg.layer.cornerRadius=8;
        }
        else if (WDQiphone6Plus())
        {
            miniWidth=370/3;
            bg.layer.cornerRadius=8;
        }
        else
        {
            miniWidth=110;
            bg.layer.cornerRadius=4;
        }
        if(lable.frame.size.width<miniWidth-2*spaceX)
        {
            float startX=(miniWidth-lable.frame.size.width)/2;
            lable.frame=CGRectMake(startX, lable.frame.origin.y, lable.frame.size.width, lable.frame.size.height);
            bg.frame=CGRectMake(0, 0, miniWidth, bg.frame.size.height);
        }
 
    }
    
    return bg;
}


+(UIView*)getToastViewWithType:(TosatType)type message:(NSString*)message bounds:(CGRect)bounds
{//icon＋文字  居中调用
    UIView *bg=[[UIView alloc] initWithFrame:bounds] ;
    bg.backgroundColor=[UIColor clearColor];
    bg.userInteractionEnabled=YES;
    bg.multipleTouchEnabled=YES;
    
    CGRect frame=toastFrame;
   
    UIView *toastVIew=[[UIView alloc] initWithFrame:frame] ;
    [bg addSubview:toastVIew];
    toastVIew.backgroundColor=[UIColor blackColor];
    toastVIew.alpha=0.7;
    //toastVIew.backgroundColor=[UIColor colorWithWhite:kToastColor alpha:kToastAlpha];
    toastVIew.layer.cornerRadius=8;
    toastVIew.layer.masksToBounds=YES;
    toastVIew.center=bg.center;
    
    float font=isPad?17:9;
    
    float width=45;
    if (isPad) {
        width=58;
    }
    else if (WDQiphone6Plus())
    {
        width=27;
        font=14;
    }
    else if (WDQiphone6())
    {
        width=24;
        font=11;
    }
    else
    {
        width=20;
        font=9;
    }
    
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)] ;
    [bg addSubview:img];
    if (isPad) {
        img.center=CGPointMake(toastVIew.center.x, toastVIew.center.y-25);
    }
    else
    {
        if (WDQiphone6Plus()) {
            img.center=CGPointMake(toastVIew.center.x, toastVIew.center.y-15);
        }
        else if(WDQiphone6())
        {
           img.center=CGPointMake(toastVIew.center.x, toastVIew.center.y-15);
        }
        else
            img.center=CGPointMake(toastVIew.center.x, toastVIew.center.y-10);
    }
    
    
    switch (type) {
        case toast_wait:
        {
            if (isPad) {
                img.image=[UIImage imageNamed:@"toast_wait_ipad.png"];
            }
            else
            {
                if (WDQiphone6()) {
                    img.frame=CGRectMake(0, 0, 35*1.2, 35*1.2);
                }
                else
                    img.frame=CGRectMake(0, 0, 35, 35);
                img.center=CGPointMake(toastVIew.center.x, toastVIew.center.y-10);
                img.image=[UIImage imageNamed:@"toast_wait.png"];
            }
           
        }
            break;
        case toast_loading:
        {
            
            if (isPad) {
                img.image=[UIImage imageNamed:@"toast_loading_ipad.png"];
            }
            else
            {
                
                img.image=[UIImage imageNamed:@"toast_loading.png"];
            }
            
            
            CABasicAnimation *animation = [CABasicAnimation animation];
            animation.keyPath = @"transform.rotation";
            animation.duration = 0.5f;
            animation.fromValue = @(0.0f);
            animation.toValue = @(2 * M_PI);
            animation.repeatCount = INFINITY;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [img.layer addAnimation:animation forKey:@"rotation"];
        }
            break;
        case toast_upload:
        {
            if (isPad) {
                img.image=[UIImage imageNamed:@"toast_upload_ipad.png"];
            }
            else
            {
                if (WDQiphone6()) {
                    img.frame=CGRectMake(0, 0, 35*1.2, 35*1.2);
                }
                else
                    img.frame=CGRectMake(0, 0, 35, 35);

                img.center=CGPointMake(toastVIew.center.x, toastVIew.center.y-10);
                img.image=[UIImage imageNamed:@"toast_upload.png"];
            }
            
        }
            break;
        default:
        {
            if (isPad) {
                img.image=[UIImage imageNamed:@"toast_wait_ipad.png"];
            }
            else
            {
                img.frame=CGRectMake(0, 0, width+10, width+10);
                img.center=CGPointMake(toastVIew.center.x, toastVIew.center.y-10);
                img.image=[UIImage imageNamed:@"toast_wait.png"];
            }

        }
            break;
    }
    
    
    
    NSString* string=nil;
#if DEBUG
    string=[NSString stringWithFormat:@"%@-Debug",message];
#else
    string=[NSString stringWithFormat:@"%@",message];
#endif
    
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, toastVIew.frame.size.width, font*2+10)] ;
    [bg addSubview:lable];
    if (isPad) {
        lable.center=CGPointMake(toastVIew.center.x, toastVIew.center.y+30);
    }
    else
    {
        if (WDQiphone6Plus()) {
            lable.center=CGPointMake(toastVIew.center.x, toastVIew.center.y+25);
        }
        else if (WDQiphone6())
        {
            lable.center=CGPointMake(toastVIew.center.x, toastVIew.center.y+20);
        }
        else
            lable.center=CGPointMake(toastVIew.center.x, toastVIew.center.y+15);

    }
    
    
    lable.backgroundColor=[UIColor clearColor];
    lable.font=[UIFont systemFontOfSize:font];
    lable.text=string;
    lable.textAlignment=NSTextAlignmentCenter;
    lable.textColor=[UIColor whiteColor];
    return bg;
}

+(BOOL)isHasToastView:(UIView*)superView
{
     UIView *toastView=[superView viewWithTag:1234567];
    if (toastView) {
        return YES;
    }
    return NO;
    
}

@end
