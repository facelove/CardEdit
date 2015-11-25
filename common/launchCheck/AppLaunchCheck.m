//
//  AppLaunchCheck.m
//  demo
//
//  Created by wangdaoqinqiyi on 15/9/10.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import "AppLaunchCheck.h"

/*
 version                    本地版本
 versionFirstLaunch         本版本第一次启动
 appFirstLaunch             app第一次启动
 */

@implementation AppLaunchCheck
+(BOOL)checkVersionChange
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    float version=[[CommonUtil getVersion] floatValue];
    if ([user objectForKey:@"version"])
    {
        float currentVersion=[[user objectForKey:@"version"] floatValue];
        if (currentVersion!=version)
        {
            [AppLaunchCheck refreshOldSetting];
            [AppLaunchCheck updateDB];
            [user setObject:[NSNumber numberWithFloat:version] forKey:@"version"];
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        [user setObject:[NSNumber numberWithFloat:version] forKey:@"version"];
        return NO;
    }
}

#pragma mark ----private mothod----
+(void)refreshOldSetting
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"versionFirstLaunch"];//删除版本第一次启动标示
}
+(void)updateDB
{
}
@end
