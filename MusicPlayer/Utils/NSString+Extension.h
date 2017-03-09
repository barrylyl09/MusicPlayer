//
//  NSString+Extension.h
//  MusicPlayer
//
//  Created by lyl on 2017/3/9.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/* 获取播放时间 */
+ (NSString *)stringWithTime:(NSTimeInterval)time;

@end
