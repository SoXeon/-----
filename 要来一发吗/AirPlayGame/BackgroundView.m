//
//  BackgroundView.m
//  要来一发吗
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "BackgroundView.h"

@interface BackgroundView()

@property (weak,nonatomic) UIImageView *bg1;
@property (weak,nonatomic) UIImageView *bg2;

@end

@implementation BackgroundView

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        //实例化图片
        UIImageView *bg1 = [[UIImageView alloc]initWithImage:image];
        [self addSubview:bg1];
        self.bg1 = bg1;
        
        UIImageView *bg2 = [[UIImageView alloc]initWithImage:image];
        [self addSubview:bg2];
        self.bg2 = bg2;
    }
    return self;
}

-(void)changBGWithFrame1:(CGRect)frame1 rame2:(CGRect)frame2
{
    [self.bg1 setFrame:frame1];
    [self.bg2 setFrame:frame2];
}

@end
