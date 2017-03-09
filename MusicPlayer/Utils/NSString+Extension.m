//
//  NSString+Extension.m
//  MusicPlayer
//
//  Created by lyl on 2017/3/9.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (NSString *)stringWithTime:(NSTimeInterval)time
{
    NSInteger min = time / 60;
    NSInteger sec = (NSInteger)round(time) % 60;
    NSString *str = [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
    
    return str;
}

@end
