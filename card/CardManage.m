//
//  CardManage.m
//  demo
//
//  Created by 王道钦 on 15/9/23.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import "CardManage.h"


@implementation CardManage
static NSString *cellIndentifier1 = @"CellIndentifier1";
static NSString *cellIndentifier2 = @"CellIndentifier2";
static NSString *cellIndentifier3 = @"CellIndentifier3";
static NSString *cellIndentifier4 = @"CellIndentifier4";
static NSString *cellIndentifier5 = @"CellIndentifier5";
static NSString *cellIndentifier6 = @"CellIndentifier6";
static NSString *cellIndentifier7 = @"CellIndentifier7";
static NSString *cellIndentifier8 = @"CellIndentifier8";

static CardManage *cardManage = nil;
dispatch_once_t  onetoken;
+ (instancetype)shardManage {
    
    dispatch_once(&onetoken, ^{
        if (!cardManage) {
            cardManage = [[self alloc] init];
        }
    });
    return cardManage;
}

-(NSString*)getCellIndentifierForm:(int)cardType
{
    switch (cardType) {
        case 1:
            return cellIndentifier1;
            break;
        case 2:
            return cellIndentifier2;
            break;
        case 3:
            return cellIndentifier3;
            break;
        case 4:
            return cellIndentifier4;
            break;
        case 5:
            return cellIndentifier5;
            break;
        case 6:
            return cellIndentifier6;
            break;
        case 7:
            return cellIndentifier7;
            break;
        case 8:
            return cellIndentifier8;
            break;
        default:
            return @"aaa";
            break;
    }
}


- (BaseCard *)createCardWith:(CellDataObj *)cellDatas delegate:(id<BaseCardDelegate>)del
{
    if (!cellDatas) {
        NSLog(@"cardDatas  is nil !!!");
        return nil;
    }

    NSString *tmpCardType =cellDatas.card;
    NSString *cardClassName=[NSString stringWithFormat:@"CardCell%d",[tmpCardType intValue]];
//    BaseCard *card = [[NSClassFromString(cardClassName) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self getCellIndentifierForm:[tmpCardType intValue]]];
    BaseCard *card = [[NSClassFromString(cardClassName) alloc] init];
    card.delegate=del;
    [card loadDisplayContenWith:cellDatas];
    return card;
}




@end
