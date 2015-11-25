//
//  QYUIMacro.m
//  QiYiVideo
//
//  Created by cissu on 12-11-28.
//  Copyright (c) 2012年 QiYi. All rights reserved.
//

#import "QYUIMacro.h"


CGSize screenSize(void)
{
    CGRect screen_rect = [[UIScreen mainScreen] bounds];
    CGSize size = CGSizeZero;
    //    UIWindow * w = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    //    BOOL wl = w.windowLevel == UIWindowLevelNormal ? YES : NO;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL status_hide = [[UIApplication sharedApplication] isStatusBarHidden];
    CGRect status_bar_frame = [[UIApplication sharedApplication] statusBarFrame];
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
        if (status_hide)
        {
            size.width = MIN(screen_rect.size.width, screen_rect.size.height);
            size.height = MAX(screen_rect.size.width, screen_rect.size.height);
        }
        else
        {
            size.width = MIN(screen_rect.size.width, screen_rect.size.height);
            size.height = MAX(screen_rect.size.width, screen_rect.size.height) - MIN(status_bar_frame.size.height, status_bar_frame.size.width);
        }
    }
    else
    {
        if (status_hide)
        {
            size.height = MIN(screen_rect.size.width, screen_rect.size.height);
            size.width = MAX(screen_rect.size.width, screen_rect.size.height);
        }
        else
        {
            size.height = MIN(screen_rect.size.width, screen_rect.size.height) - MIN(status_bar_frame.size.height, status_bar_frame.size.width);
            size.width = MAX(screen_rect.size.width, screen_rect.size.height);
        }
    }
    return size;
}

UIImage * imageWithColor(UIColor * color)//!from internet
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
