//
//  NSString+Parse.m
//  demo
//
//  Created by wangdaoqinqiyi on 15/9/26.
//  Copyright © 2015年 wangdaoqinqiyi. All rights reserved.
//

#import "NSString+Parse.h"

@implementation NSString(NSString_Parse)

- (id)JSONSerializationValue
{
    NSDictionary *resultJSON  = nil;
    @try {
        NSData *resultData = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        resultJSON = [NSJSONSerialization JSONObjectWithData:resultData options:kNilOptions error:&error];
        
        if (!resultJSON || error) {
            NSLog(@"qiyilib -JSONSerializationValue failed. Error:%@",error);
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@ , %@" , exception , [exception callStackSymbols]);
    }
    @finally {
        
    }
    return resultJSON;
}

@end
