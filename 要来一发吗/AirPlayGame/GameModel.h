//
//  GameModel.h
//  要来一发吗
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hero.h"

@interface GameModel : NSObject

#pragma mark －工厂方法
+ (id)gameModelWithArea:(CGRect)gameArea heroSize:(CGSize)heroSize;

#pragma mark 游戏区域
@property (assign,nonatomic) CGRect gameArea;

#pragma mark 背景图片的位置
@property (assign,nonatomic) CGRect bgFrame1;
@property (assign,nonatomic) CGRect bgFrame2;

#pragma mark 成员方法
#pragma mark 背景图片向下走
- (void)bgMoveDown;

#pragma mark 英雄灰机的属性及方法
@property (strong,nonatomic) Hero *hero;

@end
