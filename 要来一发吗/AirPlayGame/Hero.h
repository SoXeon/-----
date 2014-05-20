//
//  Hero.h
//  要来一发吗
//
//  Created by DP on 14-5-19.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero : NSObject

#pragma mark -工厂方法
//根据英雄的size和gameArea计算英雄应该出现的位置
+ (id)heroWithSize:(CGSize)size gameArea:(CGRect)gameArea;

//中心点位置
@property (assign,nonatomic) CGPoint postion;
//飞机的尺寸
@property (assign,nonatomic) CGSize size;
//英雄碰撞检测frame
@property (assign,nonatomic,readonly) CGRect collisionFrame;
//炸弹的数量
@property (assign,nonatomic) NSInteger bombCount;
//子弹是否增强
@property (assign,nonatomic) BOOL isEnhanceBullet;
//子弹增强时间
@property (assign,nonatomic) NSInteger enhanceTime;

#pragma mark 子弹辅助属性
//普通子弹尺寸
@property (assign,nonatomic) CGSize bulletNormalSize;

//加强子弹尺寸
@property (assign,nonatomic) CGSize bulletEnhancedSize;

//发射子弹的集合,相对数组是无序的，set的委会开销比array小，通常在处理无序对象时使用
@property (strong,nonatomic) NSMutableSet  *bulletSet;

-(void)fire;
@end
