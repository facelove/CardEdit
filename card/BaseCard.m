//
//  BaseCard.m
//  demo
//
//  Created by 王道钦 on 15/9/23.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//
//测试git
#import "BaseCard.h"

@implementation BaseCard

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        return self;
    }
    return nil;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(NSString*)getImgPath
{
    return @"http://localhost/ios";
}

- (void)loadDisplayContenWith:(CellDataObj *)cellDatas {
}

@end
