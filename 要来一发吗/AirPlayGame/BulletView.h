//
//  BulletView.h
//  要来一发吗
//
//  Created by DP on 14-5-19.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bullet.h"

@interface BulletView : UIImageView

//记录这一时刻的子弹模型对象，方便后续子弹打飞机逻辑打处理
@property (strong,nonatomic) Bullet *bullet;

- (id)initWithImage:(UIImage *)image bullet:(Bullet *)bullet;

@end
