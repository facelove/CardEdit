//
//  CardContrainsSquareType.m
//  demo
//
//  Created by 王道钦 on 15/9/23.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import "CardCell1.h"
#import "SDWebImage/SDWebImageDownloader.h"
@interface CardCell1()


@end

@implementation CardCell1

- (void)loadDisplayContenWith:(CellDataObj *)cellDatas {
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
        
        
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[self getImgPath],obj.imgURL]] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setBackgroundImage:image forState:UIControlStateNormal];
            });
            
        }];
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        float imageWidth=90.0;
        float imageHeight=83;
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
    }
    return nil;
    
}
-(void)buttonPress:(UIButton*)sender
{
//    int index=sender.tag;
        
    
    
}


@end
