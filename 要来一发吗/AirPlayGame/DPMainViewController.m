//
//  DPMainViewController.m
//  要来一发吗
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "DPMainViewController.h"
#import "LoadingView.h"
#import "TitleView.h"
#import "AirPlayGameViewController.h"

@interface DPMainViewController ()

//加载视图
@property (weak,nonatomic) LoadingView *loadingView;

//标题视图
@property (weak,nonatomic) TitleView *titleView;

//游戏视图控制器
@property (strong,nonatomic) AirPlayGameViewController *gameController;

@end

@implementation DPMainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //显示加载视图
    LoadingView *loadingview = [[LoadingView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:loadingview];
    self.loadingView = loadingview;
    
    //用后台方式，加载游戏素材资源
    [self performSelectorInBackground:@selector(loadResources) withObject:nil];
    
}

#pragma mark 后台加载资源
-(void)loadResources
{
    //加载资源
    [NSThread sleepForTimeInterval:2.0];
    //实例化游戏视图控制器
    self.gameController = [[AirPlayGameViewController alloc]init];
    [self.gameController loadResources];
    
    //删除loadView
    [self.loadingView removeFromSuperview];
    
    //显示标题视图
    TitleView *titleView = [[TitleView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    //后台调用beginGame方法，当游戏素材准备就绪后，进入游戏
    [self performSelectorInBackground:@selector(beginGame) withObject:nil];
}

- (void)beginGame
{
    //删除标题视图
    [NSThread sleepForTimeInterval:1.0f];
    [self.titleView removeFromSuperview];
    
    //显示游戏视图控制器
    [self.view addSubview:self.gameController.view];
}

@end
