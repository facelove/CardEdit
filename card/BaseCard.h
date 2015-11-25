//
//  BaseCard.h
//  demo
//
//  Created by 王道钦 on 15/9/23.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDataObj.h"
#import "CardDataObj.h"

@protocol BaseCardDelegate <NSObject>

-(void)didPressCardData:(CardDataObj*)obj;

@end


@interface BaseCard : UITableViewCell
@property(nonatomic,strong)CellDataObj*celldata;
@property(nonatomic,assign)id<BaseCardDelegate>delegate;
- (void)loadDisplayContenWith:(CellDataObj *)cellDatas;
-(NSString*)getImgPath;
@end

