//
//  PlayerTool.m
//  MusicPlayer
//
//  Created by lyl on 2017/3/8.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "PlayerTool.h"
#import "MusicModel.h"
#import "MJExtension.h"

@implementation PlayerTool

static NSArray * songs;
static MusicModel * musicObj;

#pragma mark ---初始化播放音乐，和播放列表
+ (void)initialize
{
    if (songs == nil) {
        songs = [MusicModel mj_objectArrayWithFilename:@"Music.plist"];
    }
    if (musicObj == nil) {
        musicObj = songs[0];
    }
}

+ (NSArray *)songs
{
    return songs;
}

+ (MusicModel *)musicObj
{
    return musicObj;
}

+ (void)setUpPlayingMusic:(MusicModel *)playingMusic
{
    musicObj = playingMusic;
}

+ (MusicModel *)lastMusic
{
    NSInteger idx = [songs indexOfObject:musicObj];
    
    if (idx == 0) {
        idx = songs.count - 1;
    }else {
        idx = idx - 1;
    }
    
    MusicModel *lastMusic = songs[idx];
    
    return lastMusic;
}

+ (MusicModel *)nextMusic
{
    NSInteger idx = [songs indexOfObject:musicObj];
    
    if (idx == songs.count -1) {
        idx = 0;
    }else {
        idx = idx + 1;
    }
    
    MusicModel *nextMusic = songs[idx];
    
    return nextMusic;
}

@end
