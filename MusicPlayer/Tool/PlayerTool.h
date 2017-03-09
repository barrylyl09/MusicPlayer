//
//  PlayerTool.h
//  MusicPlayer
//
//  Created by lyl on 2017/3/8.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MusicModel;

@interface PlayerTool : NSObject

/* 获取所有音乐 */
+ (NSArray *)songs;

/* 当前播放音乐 */
+ (MusicModel *)musicObj;

/* 设置默认播放音乐 */
+ (void)setUpPlayingMusic:(MusicModel *)playingMusic;

/* 上一首 */
+ (MusicModel *)lastMusic;

/* 下一首 */
+ (MusicModel *)nextMusic;

@end
