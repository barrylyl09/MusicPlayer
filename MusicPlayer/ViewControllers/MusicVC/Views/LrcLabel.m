//
//  LrcLabel.m
//  MusicPlayer
//
//  Created by lyl on 2017/3/10.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "LrcLabel.h"
#import "macro_define.h"
@implementation LrcLabel

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

/* 着色歌词条 */
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [[UIColor greenColor] set];
    CGRect fillRect = CGRectMake(0, 0, ScreenWidth * self.progress, ScreenHeight);
    
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}

@end
