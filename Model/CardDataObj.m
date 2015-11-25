//
//  CardDataObj.m
//  demo
//
//  Created by 王道钦 on 15/9/26.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import "CardDataObj.h"
#import <objc/runtime.h>
@implementation CardDataObj
-(instancetype)initWithDirectry:(NSDictionary*)dic
{
    if (self=[super init]) {
        
    }
    return self;
}


+(CardDataObj*)fillDataWithRunTime:(NSDictionary*)dic
{
    
    CardDataObj *instane=[[CardDataObj alloc] init];
    unsigned int numIvars; //成员变量个数
    Ivar *vars = class_copyIvarList(NSClassFromString(@"CardDataObj"), &numIvars);
    //Ivar *vars = class_copyIvarList([UIView class], &numIvars);
    
    NSString *key=nil;
    for(int i = 0; i < numIvars; i++)
    {
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
//        DNSLog(@"variable name :%@", key);
//        key = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)]; //获取成员变量的数据类型
//        DNSLog(@"variable type :%@", key);
        //区别 公有或私有变量，如果是公有变量将是是_xxx形式
        key=[key hasPrefix:@"_"]?[key stringByReplacingOccurrencesOfString:@"_" withString:@""]:key;
        
        if ([dic objectForKey:key])
        {
            object_setIvar(instane, thisIvar,[CommonUtil getParam:[dic objectForKey:key]] );
        }
    }
    free(vars);
    
    return instane;
}

@end
