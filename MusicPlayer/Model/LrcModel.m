//
//  LrcModel.m
//  MusicPlayer
//
//  Created by lyl on 2017/3/10.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "LrcModel.h"

@implementation LrcModel

+ (instancetype)lrcString:(NSString *)lrcStr
{
    return [[self alloc] initWithLrcString:lrcStr];
}

- (instancetype)initWithLrcString:(NSString *)lrcStr
{
    if (self = [super init]) {
        NSArray *lrcArr = [lrcStr componentsSeparatedByString:@"]"];
        _lrcText = lrcArr[1];
        NSLog(@"----:%@\n",_lrcText);
        NSLog(@"====:%@\n",lrcArr[0]);
        _time = [self timeWithString:[lrcArr[0] substringFromIndex:1]];  //从字符串第二个字符开始截取
    }
    
    return self;
}

- (NSTimeInterval)timeWithString:(NSString *)timeStr
{
    NSInteger min = [[timeStr componentsSeparatedByString:@":"][0] integerValue];
    
    NSInteger sec = [[timeStr substringWithRange:NSMakeRange(3, 2)] integerValue];
    NSInteger hs = [[timeStr componentsSeparatedByString:@"."][1] integerValue];
 
    /* min:sec:hs 返回时间结构 */
    return min*60 + sec + hs*0.01;
}


@end
