//
//  Hero.m
//  要来一发吗
//
//  Created by DP on 14-5-19.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "Hero.h"
#import "Bullet.h"

#define kFireCount 3

@implementation Hero

+(id)heroWithSize:(CGSize)size gameArea:(CGRect)gameArea
{
    Hero * h = [[Hero alloc]init];
    
    //计算位置
    CGFloat x = gameArea.size.width / 2;
    CGFloat y = gameArea.size.height - size.height;
    
    h.postion = CGPointMake(x, y);
    h.size = size;
    
    h.bombCount = 0;
    h.isEnhanceBullet = NO;
    h.enhanceTime = 0;
    
    //实例化子弹集合
    h.bulletSet = [NSMutableSet set];
    
    return h;
}

#pragma mark  碰撞检测使用的frame
- (CGRect)collisionFrame
{
    CGFloat x = self.postion.x - self.size.width / 4.0;
    CGFloat y = self.postion.y - self.size.height / 2.0;
    CGFloat w = self.size.width / 2.0;
    CGFloat h = self.size.height;
    
    return CGRectMake(x, y, w, h);
    
}


#pragma mark 给子弹添加成员方法
//指定bulletNoramlSize 和bulletEnhancedSize
-(void)fire
{
    //循环发射子弹，创建kFireCount个实例
    //根据子弹是否加强来计算当前使用子弹的大小
    CGSize bulletSize = self.bulletNormalSize;
    if (self.isEnhanceBullet) {
        bulletSize = self.bulletEnhancedSize;
    }
    
    //计算第一颗子弹的y坐标
    CGFloat y = self.postion.y - self.size.height / 2 - bulletSize.height / 2;
    CGFloat x = self.postion.x;
    
    
    for (NSInteger i = 0; i < kFireCount; i++) {
        CGPoint p = CGPointMake(x, y - i * bulletSize.height * 2);
        Bullet *b = [Bullet bulletWithPosition:p isEnhanced:self.isEnhanceBullet];
        [self.bulletSet addObject:b];
    }
}

@end
