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
#import "SoundTool.h"

#import "BackgroundView.h"
#import "HeroViiew.h"
#import "BulletView.h"
#import "EnemyView.h"

static long steps;

@interface AirPlayGameViewController ()

//游戏时钟
@property (strong,nonatomic) CADisplayLink *gameTimer;

//图形资源缓存
@property (strong,nonatomic) ImageResources *imageRes;

//声音工具缓存
@property (strong,nonatomic) SoundTool *soundTool;

//游戏模型
@property (strong,nonatomic) GameModel *gameModel;

//游戏视图
@property (weak,nonatomic) UIView *gameView;

//背景视图
@property (weak,nonatomic) BackgroundView *bgView;

//英雄灰机视图
@property (weak,nonatomic) HeroViiew *heroView;

//子弹视图集合,记录屏幕中所有的子弹视图
@property (strong,nonatomic) NSMutableSet *bulletViewSet;

//敌机集合
@property (strong,nonatomic) NSMutableSet *enemyViewSet;

//得分标签
@property (weak,nonatomic) UILabel *scoreLabel;

@end

@implementation AirPlayGameViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //播放背景音乐
    [self.soundTool playMusic];
    
    steps = 0;
    
    //实例化集合
    self.bulletViewSet = [NSMutableSet set];
    self.enemyViewSet = [NSMutableSet set];
    
    //实例化游戏模型
    CGSize heroSize = [self.imageRes.heroFlyImages[0]size];
    self.gameModel = [GameModel gameModelWithArea:self.view.bounds heroSize:heroSize];
    
    [self.gameModel.hero setBulletNormalSize:self.imageRes.bulletNormalImage.size];
    [self.gameModel.hero setBulletEnhancedSize:self.imageRes.bulletEnhancedImage.size];
    
    //实例化游戏视图，游戏中的所有元素都添加到游戏视图中
    UIView *gameView = [[UIView alloc] initWithFrame:self.gameModel.gameArea];
    [self.view addSubview:gameView];
    self.gameView = gameView;
    
    //添加暂停按钮和得分标签
    //1.暂停按钮
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *pauseImage = [UIImage imageNamed:@"images.bundle/BurstAircraftPause.png"];
    [pauseButton setImage:pauseImage forState:UIControlStateNormal];
    
    UIImage *pauseImageHL = [UIImage imageNamed:@"images.bundle/BurstAircraftPauseHL.png"];
    [pauseButton setImage:pauseImageHL forState:UIControlStateHighlighted];
    
    [pauseButton setFrame:CGRectMake(20, 20, pauseImage.size.width, pauseImage.size.height)];
    
    [self.view addSubview:pauseButton];
    
    //添加监听方法
    [pauseButton addTarget:self action:@selector(tapPauseButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //得分标签
    CGFloat labelX = pauseButton.frame.origin.x + pauseButton.frame.size.width;
    CGFloat labelY = 20;
    CGFloat labelW = self.gameModel.gameArea.size.width - labelX;
    CGFloat labelH = pauseButton.frame.size.height;
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    [scoreLabel setFont:[UIFont fontWithName:@"Marker Felt" size:21]];
    [scoreLabel setTextColor:[UIColor darkGrayColor]];
    self.scoreLabel = scoreLabel;
    [self.view addSubview:scoreLabel];
    
    
    
    //实例化背景图片
    BackgroundView *bgView = [[BackgroundView alloc]initWithFrame:self.gameModel.gameArea image:self.imageRes.bgImage];
    [self.gameView addSubview:bgView];
    self.bgView = bgView;
    
    //实例化英雄视图
    HeroViiew *heroView = [[HeroViiew alloc]initWithImages:self.imageRes.heroFlyImages];
    [heroView setCenter:self.gameModel.hero.postion];
    [self.gameView addSubview:heroView];
    self.heroView = heroView;
    
    //启动游戏时钟
    [self startGameTimer];
}

#pragma mark 触摸事件
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //取出触摸对象
    UITouch *touch = [touches anyObject];
    
    //取出当前触摸点
    CGPoint location = [touch locationInView:self.gameView];
    
    //取出之前触摸点
    CGPoint prelocation = [touch previousLocationInView:self.gameView];

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
        [self.soundTool playSoundByFileName:@"bullet"];
    }
    
    //时钟触发，检查所有子弹的位置
    [self checkBullects];
    
    //创建敌机
    if (steps % 20 == 0) {
        //创建模型
        Enemy *enemy  = nil;
        if (steps % (5 * 60 ) == 0) {
            //随机出现大飞机和中飞机
            EnemyType type = (arc4random_uniform(2) == 0) ? kEnemyMiddle : kEnemyBig;
            CGSize size = self.imageRes.enemyMiddleImage.size;
            if (kEnemyBig == type) {
                size = [self.imageRes.enemyBigImage[0]size];
            }
            enemy = [self.gameModel createEnemyWithType:type size:size];
            
        } else {
        //小飞机
        enemy = [self.gameModel createEnemyWithType:kEnemySmall size:self.imageRes.enemySmallImage.size];
        }

        //根据模型船舰飞机视图
        EnemyView *enemyView = [[EnemyView alloc]initWithEnemy:enemy imageRes:self.imageRes];
        
        //将敌机视图添加到集合及主视图中
        [self.enemyViewSet addObject:enemyView];
        [self.gameView addSubview:enemyView];
    }
    
    //更新飞机位置
    [self updateEnemys];
    
    //碰撞检测
    [self collisionDetector];
}

#pragma mark 碰撞检测
-(void)collisionDetector
{
    //调整爆炸动画效果
    if (steps % 10 == 0) {
    
    //遍历飞机集合，判断toBlowup为真的飞机开始播放动画
    NSMutableSet *toRemovedSet = [NSMutableSet set];
    for (EnemyView *enemyView in self.enemyViewSet) {
        Enemy *enemy = enemyView.enemy;
        if (enemy.toBlowup) {
            [enemyView setImage:enemyView.blowupImages[enemy.blowupFrames++]];
        }
        
        //判断动画是否播放到最后一帧
        if (enemy.blowupFrames == enemyView.blowupImages.count) {
            //需要从集合中删除飞机
            [toRemovedSet addObject:enemyView];
        }
    }
    
    for (EnemyView *enemyView in toRemovedSet) {
        //修改游戏模型中到得分，更新标签显示
        self.gameModel.score += enemyView.enemy.score;
        [self updateScoreLabel];
        
        [self.enemyViewSet removeObject:enemyView];
        [enemyView removeFromSuperview];
    }
    [toRemovedSet removeAllObjects];
 }
    
    //子弹集合，敌机集合
    for (BulletView *bulletView in self.bulletViewSet) {
        Bullet *bullet = bulletView.bullet;
        for (EnemyView *enemyView in self.enemyViewSet) {
            Enemy *enemy = enemyView.enemy;
            
            //检查子弹和敌机的frame是否相交,碰撞检测
            //如果敌机处于爆炸中，不做和敌机碰撞检测
            if (CGRectIntersectsRect(bulletView.frame, enemyView.frame) && !enemy.toBlowup) {
                //用子弹的damage减敌机的hp
                enemy.hp -= bullet.damage;
                
                if (enemy.hp <= 0) {
                    //播放飞机爆炸的序列帧图片
                    enemy.toBlowup = YES;
                } else {
                    //如果是大飞机要停止序列帧动画
                    if (enemy.type == kEnemyBig) {
                        [enemyView stopAnimating];
                    }
                    enemyView.image = enemyView.hitImage;
                }
            }
        }
    }
    
    //英雄灰机和敌机的碰撞
    //遍历敌机集合，若和英雄碰撞，英雄over，游戏结束
    for (EnemyView *enemyView in self.enemyViewSet) {
        if (CGRectIntersectsRect(enemyView.frame, self.gameModel.hero.collisionFrame)) {
            //设置英雄灰机爆炸后的最后影像
            [self.heroView setImage:self.imageRes.heroBlowUpImages[3]];
            [self.soundTool playSoundByFileName:@"game_over"];
            //英雄灰机爆炸
            [self.heroView stopAnimating];
            [self.heroView setAnimationImages:self.imageRes.heroBlowUpImages];
            [self.heroView setAnimationDuration:1.0f];
            [self.heroView setAnimationRepeatCount:1];
            [self.heroView startAnimating];
            [self performSelector:@selector(stopGameTimer) withObject:nil afterDelay:1.0f];
            
            //直接跳出循环，不再遍历
            break;
        }
    }
}

#pragma mark 开始游戏时钟
- (void)startGameTimer
{
    self.gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    [self.gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark 停止游戏时钟
-(void)stopGameTimer
{
    //通过时钟来处理界面的变化，如果把时钟停止，游戏将停止
    [self.gameTimer invalidate];
}

#pragma mark 更新飞机位置
-(void)updateEnemys
{
    
    //每帧按照集合中到飞机速度下降
    for (EnemyView *enemyView in self.enemyViewSet) {
        Enemy *enemy = enemyView.enemy;
        //更新position属性
        enemy.position = CGPointMake(enemy.position.x, enemy.position.y + enemy.speed);
        //根据position属性调整敌机位置
        [enemyView setCenter:enemy.position];
    }
    //遍历集合，如果飞机移除屏幕，需要从集合和视图中删除
    NSMutableSet *toRemovedSet = [NSMutableSet set];
    for (EnemyView *enemyView in self.enemyViewSet) {
        
        if (enemyView.frame.origin.y >= self.gameModel.gameArea.size.height) {
            //需要删除
            [toRemovedSet addObject:enemyView];
        }
    }
    for (EnemyView * enemyView in toRemovedSet) {
        [enemyView removeFromSuperview];
        [self.enemyViewSet removeObject:enemyView];
    }
    //清空缓存集合
    [toRemovedSet removeAllObjects];
}

#pragma mark 检查子弹位置，数量
-(void)checkBullects
{

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
        
        [self.gameView addSubview:bulletView];
        [self.bulletViewSet addObject:bulletView];
    }
    //清空子弹集合
    [self.gameModel.hero.bulletSet removeAllObjects];
}

#pragma mark 按钮监听方法
-(void)tapPauseButton:(UIButton *)button
{
    button.tag = !button.tag;
    
    UIImage *image = nil;
    UIImage *imageHL = nil;
    
    if (button.tag) {
        image = [UIImage imageNamed:@"images.bundle/BurstAircraftStart.png"];
        imageHL = [UIImage imageNamed:@"images.bundle/BurstAircraftStartHL.png"];
        [self stopGameTimer];
    } else {
        image = [UIImage imageNamed:@"images.bundle/BurstAircraftPause.png"];
        imageHL = [UIImage imageNamed:@"images.bundle/BurstAircraftPauseHL.png"];
        [self startGameTimer];
    }
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imageHL forState:UIControlStateHighlighted];
}

#pragma mark 更新游戏得分标签
- (void)updateScoreLabel
{
    //判断游戏模型中到得分，如果为0，清空标签内容
    if (self.gameModel.score == 0) {
        [self.scoreLabel setText:@""];
    } else {
        NSString *str = [NSString stringWithFormat:@"%d000",self.gameModel.score];
        [self.scoreLabel setText:str];
    }
}

#pragma mark 成员函数
#pragma mark 加载图像资源
- (void)loadResources
{
    //加载图像缓存
    self.imageRes = [[ImageResources alloc]init];
    //加载背景音乐缓存
    self.soundTool = [[SoundTool alloc]init];
}



@end
