//
//  Bullet.m
//  要来一发吗
//
//  Created by DP on 14-5-19.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "Bullet.h"

#define kDamageNormal 1
#define kDamageEnhanced 2

@implementation Bullet

+(id)bulletWithPosition:(CGPoint)position isEnhanced:(BOOL)isEnhanced
{
    Bullet *b = [[Bullet alloc]init];
    
    b.position = position;
    b.isEnhanced = isEnhanced;
    
    b.damage = isEnhanced ? kDamageEnhanced :kDamageNormal;
    
    return b;
}

@end
