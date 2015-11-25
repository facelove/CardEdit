//
//  CommonUtil.m
//  demo
//
//  Created by wangdaoqinqiyi on 15/9/10.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil




+(NSString*)getVersion
{
    return [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
}
+(NSString*)getParam:(id)value
{
    if (value==nil) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    else if ([value isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%f",[value floatValue]];
    }
    else
    {
        return [NSString stringWithFormat:@"%@",value];
    }
}
@end
