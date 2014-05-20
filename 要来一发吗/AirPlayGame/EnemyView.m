//
//  EnemyView.m
//  要来一发吗
//
//  Created by DP on 14-5-19.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "EnemyView.h"

@implementation EnemyView

-(id)initWithEnemy:(Enemy *)enemy imageRes:(ImageResources *)imageRes
{
    self = [super init];
    
    if (self) {
        self.enemy = enemy;
        
        //根据敌机类型来设置相关图片
        switch (self.enemy.type) {
            case kEnemySmall:
                self.image = imageRes.enemySmallImage;
                self.blowupImages = imageRes.enemySmallBlowupImages;
                break;
            case kEnemyMiddle:
                self.image = imageRes.enemyMiddleImage;
                self.blowupImages = imageRes.enemyMiddleBlowupImages;
                self.hitImage = imageRes.enemyMiddleHitImages;
                break;
            case kEnemyBig:
                self.image = imageRes.enemyBigImage[0];
                self.animationImages = imageRes.enemyBigImage;
                self.animationDuration = 0.5f;
                [self startAnimating];
                self.blowupImages = imageRes.enemyBigBlowupImages;
                self.hitImage = imageRes.enemyBigHitImages;
                break;
        }
        [self setFrame:CGRectMake(0, 0, self.image.size.width, self.image.size.height)];
        [self  setCenter:enemy.position];
    }
    return self;
}



@end
