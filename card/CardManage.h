//
//  CardManage.h
//  demo
//
//  Created by 王道钦 on 15/9/23.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCard.h"
#import "CardDataObj.h"
#import "CellDataObj.h"
#import "CardCell1.h"
#import "CardCell2.h"
#import "CardCell3.h"
#import "CardCell4.h"
#import "CardCell5.h"
#import "CardCell6.h"
#import "CardCell7.h"
#import "CardCell8.h"
@interface CardManage : NSObject<BaseCardDelegate>

+(instancetype)shardManage;

- (BaseCard *)createCardWith:(CellDataObj *)cardDatas delegate:(id<BaseCardDelegate>)del;

@end
