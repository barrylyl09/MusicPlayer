//
//  CALayer+Extension.m
//  MusicPlayer
//
//  Created by lyl on 2017/3/9.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "CALayer+Extension.h"

@implementation CALayer (Extension)

/* 暂停、恢复 动画*/
- (void)pauseAni
{
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

- (void)resumeAni
{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval resumeTime = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = resumeTime;
}

@end
