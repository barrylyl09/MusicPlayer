//
//  AudioPlayerTool.m
//  MusicPlayer
//
//  Created by lyl on 2017/3/9.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "AudioPlayerTool.h"


@implementation AudioPlayerTool

static NSMutableDictionary *players;

+ (void)initialize
{
    players = [NSMutableDictionary dictionary];
}

+ (AVAudioPlayer *)playingMusicWithFileName:(NSString *)fileName
{
    AVAudioPlayer *player = nil;
    
    player = players[fileName];
    if (player == nil) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        
        if (url == nil) return nil;
        
        //创建AudioPlayer
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        [player prepareToPlay];
        //存储播放器
        [players setObject:player forKey:fileName];
    }

    [player play];
    
    return player;
}

+ (void)pauseMusicWithFileName:(NSString *)fileName
{
    AVAudioPlayer *player = players[fileName];
    
    if (player) [player pause];
    
}

+ (void)stopMusicWithMusicFileName:(NSString *)fileName
{
    AVAudioPlayer *player = players[fileName];
    
    if (player) {
        [player stop];
        player = nil;
        
        [players removeObjectForKey:fileName];
        
    }
}

@end
