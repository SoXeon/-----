//
//  SoundTool.h
//  要来一发吗
//
//  Created by DP on 14-5-20.
//  Copyright (c) 2014年 M2A1102. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundTool : NSObject

#pragma mark 播放背景音乐
-(void)playMusic;
#pragma mark 播放指定名称到音效
-(void)playSoundByFileName:(NSString *)fileName;
@end
