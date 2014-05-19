//
//  BulletView.m
//  要来一发吗
//
//  Created by DP on 14-5-19.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "BulletView.h"

@implementation BulletView

- (id)initWithImage:(UIImage *)image bullet:(Bullet *)bullet
{
    self = [super initWithImage:image];
    if (self) {
        self.bullet = bullet;
    }
    return self;
}


@end
