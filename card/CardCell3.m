//
//  CardContrainsRoundType.m
//  demo
//
//  Created by 王道钦 on 15/9/23.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import "CardCell3.h"

@implementation CardCell3

- (void)loadDisplayContenWith:(CellDataObj *)cellDatas {
    self.backgroundColor=[UIColor whiteColor];
    self.celldata=cellDatas;
    [self makeButtonList:cellDatas.dataArray];
}

-(UIView*)makeButtonList:(NSArray*)array
{
    for (int i=0; i<[array count]; i++)
    {
        CardDataObj*obj=[array objectAtIndex:i];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=i;
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        float imageWidth=90.0;
        float imageHeight=90.0;
        float scale=[UIScreen mainScreen].bounds.size.width/360.0;
        imageWidth=imageWidth*scale;
        imageHeight=imageHeight*scale;
        if (i<=3) {
            button.frame=CGRectMake(i*imageWidth, 0, imageWidth, imageHeight);
        }
        else if(i<=7)
        {
            button.frame=CGRectMake((i-4)*imageWidth, imageHeight, imageWidth, imageHeight);
        }
        [self addSubview:button];
        
        NSURL *path=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[self getImgPath],obj.imgURL]];
        
        UIImageView *icon=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [icon sd_setImageWithURL:path placeholderImage:nil];
        [button addSubview:icon];
        icon.center=button.center;
        sy(icon, 10);
        sx(icon, 20);
        
        
        UILabel*title=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, gw(button), 20)];
        title.text=obj.title;
        title.font=[UIFont systemFontOfSize:12];
        title.textAlignment=NSTextAlignmentCenter;
        title.backgroundColor=[UIColor clearColor];
        title.textColor=[UIColor blackColor];
        [button addSubview:title];
        sy(title, 70);
    }
    return nil;
    
}
-(void)buttonPress:(UIButton*)sender
{
    //    int index=sender.tag;
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
