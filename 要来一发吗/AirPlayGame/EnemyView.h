//
//  EnemyView.h
//  要来一发吗
//
//  Created by DP on 14-5-19.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enemy.h"
#import "ImageResources.h"

@interface EnemyView : UIImageView

//爆炸图片数组
@property (strong,nonatomic) NSArray *blowupImages;

//被打图片
@property (strong,nonatomic) UIImage *hitImage;

//敌机模型
@property (strong,nonatomic) Enemy *enemy;


- (id)initWithEnemy:(Enemy *)enemy imageRes:(ImageResources *)imageRes;

@end
