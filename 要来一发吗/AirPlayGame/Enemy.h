//
//  Enemy.h
//  要来一发吗
//
//  Created by DP on 14-5-19.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kEnemySmall = 0,
    kEnemyMiddle,
    kEnemyBig,
} EnemyType;

@interface Enemy : NSObject

#pragma  mark 工厂方法
//根据游戏时钟触发，来连续增加到游戏中，每秒增加3个敌机
//敌机到类型不同，大小不同，默认出现位置都是屏幕正上方，等待进入屏幕
//工厂方法内传入不同类型都敌机尺寸
+(id)enemyWithType:(EnemyType)type size:(CGSize)size gameArea:(CGRect)gameArea;

//类型大小
@property (assign,nonatomic) EnemyType type;
//位置
@property (assign,nonatomic) CGPoint position;
//生命值
@property (assign,nonatomic) NSInteger hp;
//速度
@property (assign,nonatomic) NSInteger speed;
//得分
@property (assign,nonatomic) NSInteger score;

//飞机鲍照标示，标示飞机要爆炸，供碰撞检测使用
@property(assign,nonatomic) BOOL toBlowup;
//爆炸动画已经播放的帧数
@property (assign,nonatomic)NSInteger blowupFrames;
@end
