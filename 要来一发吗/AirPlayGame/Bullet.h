//
//  Bullet.h
//  要来一发吗
//
//  Created by DP on 14-5-19.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bullet : NSObject

//由英雄灰机调用（循环三次），直接给子弹定位置，是否增强
+(id)bulletWithPosition:(CGPoint)position isEnhanced:(BOOL)isEnhanced;

//子弹的位置
@property (assign,nonatomic) CGPoint position;

//伤害值
@property (assign,nonatomic) NSInteger damage;

//是否是增强子弹（用于显示界面中哪一张图片）
@property (assign,nonatomic) BOOL isEnhanced;


@end
