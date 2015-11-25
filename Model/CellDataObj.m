//
//  CellDataObj.m
//  demo
//
//  Created by wangdaoqinqiyi on 15/9/26.
//  Copyright © 2015年 wangdaoqinqiyi. All rights reserved.
//
/**
 *  <#Description#>
 *
 *  @param CellDataObj <#CellDataObj description#>
 *
 *  @return return value description
 */
#import "CellDataObj.h"
#import "CardDataObj.h"

@implementation CellDataObj
+(CellDataObj*)fillDataFormDirectry:(NSDictionary*)dic
{
    CellDataObj*obj=[[CellDataObj alloc] init];
    obj.row=[CommonUtil getParam:[dic objectForKey:@"row"]];
    obj.card=[CommonUtil getParam:[dic objectForKey:@"card"]];
    obj.height=[CommonUtil getParam:[dic objectForKey:@"height"]];
    NSArray*array=[dic objectForKey:@"data"];
    NSMutableArray *objArray=[NSMutableArray array];
    if ([array isKindOfClass:[array class]])
    {
        for (int i=0; i<[array count]; i++) {
            NSDictionary *oneDataDic=[array objectAtIndex:i];
            CardDataObj *instance=[CardDataObj fillDataWithRunTime:oneDataDic];
            [objArray addObject:instance];
        }
    }
    obj.dataArray=[NSArray arrayWithArray:objArray];
    
    
    
    return obj;
}






@end
