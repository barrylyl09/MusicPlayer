//
//  LrcModel.h
//  MusicPlayer
//
//  Created by lyl on 2017/3/10.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LrcModel : NSObject

@property (nonatomic, copy) NSString *lrcText;

@property (nonatomic, assign) NSTimeInterval time;

- (instancetype)initWithLrcString:(NSString *)lrcStr;
+ (instancetype)lrcString:(NSString *)lrcStr;

@end
