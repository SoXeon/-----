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



@end
