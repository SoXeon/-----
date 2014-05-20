//
//  Enemy.m
//  要来一发吗
//
//  Created by DP on 14-5-19.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

+ (id)enemyWithType:(EnemyType)type size:(CGSize)size gameArea:(CGRect)gameArea
{
    Enemy *e = [[Enemy alloc]init];
    
    e.type =type;
    
    //计算敌机出现的位置
    CGFloat x = arc4random_uniform(gameArea.size.width - size.width) + size.width / 2.0;
    CGFloat y = -size.height / 2.0;
    e.position = CGPointMake(x, y);
    
    //根据敌机类型设置属性
    switch (type) {
        case kEnemySmall:
            e.hp = 1;
            e.speed = arc4random_uniform(4) + 2;
            e.score = 1;
            break;
        case kEnemyMiddle:
            e.hp = 10;
            e.speed = arc4random_uniform(3) + 2;
            e.score = 10;
            break;
        case kEnemyBig:
            e.hp = 25;
            e.speed = arc4random_uniform(2) + 2;
            e.score = 30;
            break;
    }
    
    e.blowupFrames = 0;
    e.toBlowup = NO;
    
    return e;
}

@end
