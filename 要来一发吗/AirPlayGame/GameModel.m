//
//  GameModel.m
//  要来一发吗
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel

#pragma mark 工厂方法
+(id)gameModelWithArea:(CGRect)gameArea heroSize:(CGSize)heroSize
{
    GameModel *m = [[GameModel alloc]init];
    
    m.gameArea = gameArea;
    
    //背景图片的边框
    m.bgFrame1 = gameArea;
    m.bgFrame2 = CGRectOffset(gameArea, 0, -gameArea.size.height);
    
    //实例化英雄
    m.hero = [Hero heroWithSize:heroSize gameArea:gameArea];
    
    //默认得分为0
    m.score = 0;
    
    return m;
}

#pragma mark 背景图片向下走
- (void)bgMoveDown
{
    //两张图片的背景统一向下移动
    self.bgFrame1 = CGRectOffset(self.bgFrame1, 0, 1);
    self.bgFrame2 = CGRectOffset(self.bgFrame2, 0, 1);
    
    CGRect topFrame = CGRectOffset(self.gameArea, 0, -self.gameArea.size.height);
    
    if (self.bgFrame1.origin.y >= self.gameArea.size.height) {
        self.bgFrame1 = topFrame;
    }
    if (self.bgFrame2.origin.y >= self.gameArea.size.height) {
        self.bgFrame2 = topFrame;
    }

}

#pragma mark 创建敌机
- (Enemy *)createEnemyWithType:(EnemyType)type size:(CGSize)size
{
    return  [Enemy enemyWithType:type size:size gameArea:self.gameArea];
}

@end
