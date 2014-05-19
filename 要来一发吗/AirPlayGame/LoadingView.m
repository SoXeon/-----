//
//  LoadingView.m
//  要来一发吗
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //实例化四张图片
        NSMutableArray *arrayM = [NSMutableArray array];
        
        for (NSInteger i = 0; i < 4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"images.bundle/loading%d.png",i];
            UIImage *image = [UIImage imageNamed:imageName];
            [arrayM addObject:image];
        }
        
        //建立UIImageView
        UIImageView *imageView = [[UIImageView alloc]initWithImage:arrayM[0]];
        
        //将UIImageView放置在中心位置
        [imageView setCenter:self.center];
        [self addSubview:imageView];
        
        //播放序列帧动画
        [imageView setAnimationImages:arrayM];
        [imageView setAnimationDuration:1.0f];
        [imageView startAnimating];
    }
    return self;
}



@end
