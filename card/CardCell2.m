//
//  CardContrainsRectangleType.m
//  demo
//
//  Created by 王道钦 on 15/9/23.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import "CardCell2.h"

@interface CardCell2 ()
@property (nonatomic , retain) CycleScrollView *mainScorllView;
@end

@implementation CardCell2


- (void)loadDisplayContenWith:(CellDataObj *)cellDatas {
    self.celldata=cellDatas;
    [self initScrollView:cellDatas.dataArray];
}

-(void)initScrollView:(NSArray*)array
{
    NSMutableArray *viewsArray = [@[] mutableCopy];
  //  NSArray *colorArray = @[@"http://www.365hls.com/img/app/1-nopay.png",@"http://www.365hls.com/img/app/reg_banner.png"];
    
    for (int i = 0; i < array.count; ++i)
    {
        CardDataObj*obj=[array objectAtIndex:i];
        NSString*string=[NSString stringWithFormat:@"%@",obj.imgURL];
        
        UIImageView *tempImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 130)];
        [tempImageView sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:nil];
        UILabel *desc=[[UILabel alloc] initWithFrame:CGRectMake(0, gh(tempImageView)-30, gw(tempImageView), 30)];
        desc.backgroundColor=RGBACOLOR(0, 0, 0, 0.5);
        desc.font=[UIFont systemFontOfSize:15];
        desc.textColor=[UIColor whiteColor];
        desc.numberOfLines=2;
        desc.text=obj.descriptions;
        [tempImageView addSubview:desc];
        
        [viewsArray addObject:tempImageView];
    }
    
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 130) animationDuration:3];
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return [array count];
    };
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        
    };
    [self addSubview:self.mainScorllView];
    
}


@end
