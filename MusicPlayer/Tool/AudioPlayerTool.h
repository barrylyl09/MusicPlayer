//
//  AudioPlayerTool.h
//  MusicPlayer
//
//  Created by lyl on 2017/3/9.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface AudioPlayerTool : NSObject

/* 播放音乐 */
+ (AVAudioPlayer *)playingMusicWithFileName:(NSString *)fileName;
/* 暂停音乐 */
+ (void)pauseMusicWithFileName:(NSString *)fileName;
/* 停止 */
+ (void)stopMusicWithMusicFileName:(NSString *)fileName;

@end
