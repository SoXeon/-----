//
//  AirPlayGameViewController.m
//  要来一发吗
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "AirPlayGameViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "GameModel.h"
#import "Bullet.h"
#import "ImageResources.h"

#import "BackgroundView.h"
#import "HeroViiew.h"
#import "BulletView.h"

static long steps;

@interface AirPlayGameViewController ()

//游戏时钟
@property (strong,nonatomic) CADisplayLink *gameTimer;

//图形资源缓存
@property (strong,nonatomic) ImageResources *imageRes;

//游戏moxing
@property (strong,nonatomic) GameModel *gameModel;

//背景视图
@property (weak,nonatomic) BackgroundView *bgView;

//英雄灰机视图
@property (weak,nonatomic) HeroViiew *heroView;

//子弹视图集合,记录屏幕中所有的子弹视图
@property (strong,nonatomic) NSMutableSet *bulletViewSet;

@end

@implementation AirPlayGameViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    steps = 0;
    
    //实例化游戏模型
    CGSize heroSize = [self.imageRes.heroFlyImages[0]size];
    self.gameModel = [GameModel gameModelWithArea:self.view.bounds heroSize:heroSize];
    
    [self.gameModel.hero setBulletNormalSize:self.imageRes.bulletNormalImage.size];
    [self.gameModel.hero setBulletEnhancedSize:self.imageRes.bulletEnhancedImage.size];
    
    //实例化背景图片
    BackgroundView *bgView = [[BackgroundView alloc]initWithFrame:self.gameModel.gameArea image:self.imageRes.bgImage];
    [self.view addSubview:bgView];
    self.bgView = bgView;
    
    //实例化英雄视图
    HeroViiew *heroView = [[HeroViiew alloc]initWithImages:self.imageRes.heroFlyImages];
    [heroView setCenter:self.gameModel.hero.postion];
    [self.view addSubview:heroView];
    self.heroView = heroView;
    
    
    //实例化游戏时钟
    self.gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    [self.gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

#pragma mark 触摸事件
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //取出触摸对象
    UITouch *touch = [touches anyObject];
    
    //取出当前触摸点
    CGPoint location = [touch locationInView:self.view];
    
    //取出之前触摸点
    CGPoint prelocation = [touch previousLocationInView:self.view];

    //计算偏移量
    CGPoint offset = CGPointMake(location.x - prelocation.x, location.y - prelocation.y);
    
    //更新英雄位置
    CGPoint position = self.gameModel.hero.postion;
    self.gameModel.hero.postion = CGPointMake(position.x + offset.x, position.y + offset.y);
}

#pragma mark 时钟触发方法
-(void)step
{
    steps++;
    
    //让游戏模型向下移动背景位置
    [self.gameModel bgMoveDown];
    
    //更新背景图片
    [self.bgView changBGWithFrame1:self.gameModel.bgFrame1 rame2:self.gameModel.bgFrame2];
    
    //更新英雄灰机位置
    [self.heroView setCenter:self.gameModel.hero.postion];
    
    //发射子弹
    if (steps % 20 == 0) {
        [self.gameModel.hero fire];
    }
    
    //时钟触发，检查所有子弹的位置
    [self checkBullects];
}

-(void)checkBullects
{
    NSLog(@"%d",self.bulletViewSet.count);
    
    if (self.bulletViewSet == nil) {
        self.bulletViewSet = [NSMutableSet set];
    }
    // 如果要删除集合中的数据，需要使用一个缓冲集合
    NSMutableSet *toRemovedSet = [NSMutableSet set];
    
    //向上移动子弹
    for (BulletView *bulletView in self.bulletViewSet) {
        CGPoint position = CGPointMake(bulletView.center.x, bulletView.center.y - 8.0);
        //移动子弹视图
        [bulletView setCenter:position];
        
        //判断子弹是否飞出屏幕
        if (CGRectGetMaxY(bulletView.frame)<0) {
            [toRemovedSet addObject:bulletView];
        }
    }
    
    //遍历要删除的集合
    for (BulletView *bulletView in toRemovedSet) {
        [bulletView removeFromSuperview];
        [self.bulletViewSet removeObject:bulletView];
    }
    //清空缓存集合
    [toRemovedSet removeAllObjects];
    
    //根据model.hero中新增加的子弹数据，添加子弹视图
    for (Bullet *bullet in self.gameModel.hero.bulletSet) {
        //新建子弹视图
        UIImage *image = self.imageRes.bulletNormalImage;
        if (bullet.isEnhanced) {
            image = self.imageRes.bulletEnhancedImage;
        }
        
        BulletView *bulletView = [[BulletView alloc]initWithImage:image bullet:bullet];
        [bulletView setCenter:bullet.position];
        
        [self.view addSubview:bulletView];
        [self.bulletViewSet addObject:bulletView];
    }
    //清空子弹集合
    [self.gameModel.hero.bulletSet removeAllObjects];
}

#pragma mark 成员函数
#pragma mark 加载图像资源
- (void)loadResources
{
    self.imageRes = [[ImageResources alloc]init];
}



@end
