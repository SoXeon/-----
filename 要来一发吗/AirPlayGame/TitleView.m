//
//  TitleView.m
//  要来一发吗
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //显示背景图片
        UIImage *bgImage = [UIImage imageNamed:@"images.bundle/background_2.png"];
        UIImageView *bg = [[UIImageView alloc]initWithImage:bgImage];
        [bg setFrame:self.frame];
        [self addSubview:bg];
        
        //显示标题图片
        UIImage *titleImage = [UIImage imageNamed:@"images.bundle/BurstAircraftLogo.png"];
        UIImageView *titleView = [[UIImageView alloc]initWithImage:titleImage];
        [titleView setCenter:self.center];
        [self addSubview:titleView];
    }
    return self;
}



@end
