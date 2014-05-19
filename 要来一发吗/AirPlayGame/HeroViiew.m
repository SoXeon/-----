//
//  HeroViiew.m
//  要来一发吗
//
//  Created by DP on 14-5-19.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "HeroViiew.h"

@implementation HeroViiew

//飞行图像数组
- (id)initWithImages:(NSArray *)images
{
    self = [super initWithImage:images[0]];
    
    if (self) {
        //设置序列帧动画
        [self setAnimationImages:images];
        //设置时间
        [self setAnimationDuration:1.0];
        //启动动画
        [self startAnimating];
    }
    
    return self;
}

@end
