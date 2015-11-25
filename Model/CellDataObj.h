//
//  CellDataObj.h
//  demo
//
//  Created by wangdaoqinqiyi on 15/9/26.
//  Copyright © 2015年 wangdaoqinqiyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellDataObj : NSObject
@property(nonatomic,strong)NSString*row;//row
@property(nonatomic,strong)NSString*height;//height
@property(nonatomic,strong)NSString*card;//card类型
@property(nonatomic,strong)NSArray*dataArray;//数据数组（cardDataObj）
+(CellDataObj*)fillDataFormDirectry:(NSDictionary*)dic;
@end
