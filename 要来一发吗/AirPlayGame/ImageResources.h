//
//  ImageResources.h
//  要来一发吗
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageResources : NSObject

#pragma mark 背景图片
@property (strong,nonatomic) UIImage *bgImage;

#pragma mark 灰机图片
//飞行数组
@property (strong,nonatomic) NSArray *heroFlyImages;
//爆炸数组
@property (strong,nonatomic) NSArray *heroBlowUpImages;


#pragma mark  子弹图片
//普通子弹
@property (strong,nonatomic) UIImage *bulletNormalImage;

//加强子弹
@property (strong,nonatomic) UIImage *bulletEnhancedImage;

#pragma mark 敌机图片
//小飞机飞行图
@property (strong,nonatomic) UIImage *enemySmallImage;
//小飞机爆炸的数组
@property (strong,nonatomic) NSArray *enemySmallBlowupImages;
//中飞机飞行的图像
@property (strong,nonatomic) UIImage *enemyMiddleImage;
//中飞机爆炸的数组
@property (strong,nonatomic) NSArray *enemyMiddleBlowupImages;
//中飞机被打的图片
@property (strong,nonatomic) UIImage *enemyMiddleHitImages;
//大飞机飞行的图片
@property (strong,nonatomic) NSArray *enemyBigImage;
//大飞机爆炸的数组
@property (strong,nonatomic) NSArray *enemyBigBlowupImages;
//大飞机被打打图片
@property (strong,nonatomic) UIImage *enemyBigHitImages;


@end
