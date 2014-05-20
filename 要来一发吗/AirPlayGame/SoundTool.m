//
//  SoundTool.m
//  要来一发吗
//
//  Created by DP on 14-5-20.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import "SoundTool.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundTool()

//音乐播放器
@property (strong,nonatomic) AVAudioPlayer *musicPlayer;

//使用数据字典来维护音效ID
@property (strong,nonatomic) NSDictionary *soundDict;

@end

@implementation SoundTool

#pragma mark 私有方法
#pragma mark 加载音效
- (SystemSoundID)loadSoundIDWithBunble:(NSBundle*)bundle name:(NSString *)name
{
    SystemSoundID soundID;
    
    NSString *path = [bundle pathForResource:name ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //c语言方法，完成bridge的转换
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    
    return soundID;
}

#pragma mark 加载声音到数据字典
- (NSDictionary *)loadSoundsWithBundle:(NSBundle *)bundle
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    
    //数组中存放所有声音到文件名
    NSArray *array = @[@"bullet",
                       @"enemy1_down",
                       @"enemy2_down",
                       @"enemy3_down",
                       @"game_over"];
    //遍历数组，创建声音id,添加到字典中
    for (NSString *name in array) {
        SystemSoundID soundId = [self loadSoundIDWithBunble:bundle name:name];
        
        //使用文件名作为键值添加到字典中
        [dictM setObject:@(soundId) forKey:name];
    }
    
    return dictM;
    
}


#pragma mark 实例化方法
- (id)init
{
    self = [super init];
    
    if (self) {
        //实例化音乐播放器，作为背景音乐
        NSString *bundlePath = [[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"Music.bundle"];
        
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        
        NSString *path = [bundle pathForResource:@"game_music" ofType:@"mp3"];
        
        NSURL *url = [NSURL fileURLWithPath:path];
        
        self.musicPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        
        //设置音乐播放器属性
        //1.设置播放循环
        [self.musicPlayer setNumberOfLoops: -1];
        //2.准备播放，将音乐加载到系统缓存，随时准备播放
        [self.musicPlayer prepareToPlay];
        
        //音效
        self.soundDict = [self loadSoundsWithBundle:bundle];
        
    }
    return self;
}

#pragma mark 使用文件名播放音效
-(void)playSoundByFileName:(NSString *)fileName
{
    SystemSoundID soundID = [self.soundDict[fileName]unsignedIntegerValue];
    
    //播放音效
    AudioServicesPlaySystemSound(soundID);
}


#pragma mark 播放背景音乐
-(void)playMusic
{
    [self.musicPlayer play];
}
@end
