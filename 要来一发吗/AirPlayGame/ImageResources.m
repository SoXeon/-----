//
//  ImageResources.m
//  要来一发吗
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "ImageResources.h"

@implementation ImageResources

#pragma mark 私有方法
#pragma mark 从指定bundle加载图片
- (UIImage *)loadImageWithBundle:(NSBundle *)bundle imageName:(NSString *)imageName
{
   //从images.bundle中加载指定文件名大图片
    NSString *path = [bundle pathForResource:imageName ofType:@"png"];
    
   return  [UIImage imageWithContentsOfFile:path];
}

#pragma mark 从指定bundle中加载序列帧图像组
- (NSArray *)loadImageWithBundle:(NSBundle *)bundle format:(NSString *)format count:(NSInteger)count
{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    
    for (NSInteger i = 1; i <= count; i++) {
        NSString *imageName = [NSString stringWithFormat:format,i];
        
        UIImage *image = [self loadImageWithBundle:bundle imageName:imageName];
        
        [arrayM addObject:image];
    }
    
    return arrayM;
}

#pragma mark 对象方法
- (id)init
{
    self = [super init];
    
    if (self) {
        //加载图片资源
        //实例化bundle
        NSString *bundlePath = [[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"images.bundle"];
        
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        
        //加载背景图片
        self.bgImage = [self loadImageWithBundle:bundle imageName:@"background_2"];
        
        //加载英雄灰机
        self.heroFlyImages = [self loadImageWithBundle:bundle format:@"hero_fly_%d" count:2];
        self.heroBlowUpImages = [self loadImageWithBundle:bundle format:@"hero_blowup_%d" count:4];
        
        //子弹图片
        self.bulletNormalImage = [self loadImageWithBundle:bundle imageName:@"bullet1"];
        self.bulletEnhancedImage = [self loadImageWithBundle:bundle imageName:@"bullet2"];
    }
    return self;
}

@end
