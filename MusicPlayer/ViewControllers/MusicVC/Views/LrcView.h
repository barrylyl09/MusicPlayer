//
//  LrcView.h
//  MusicPlayer
//
//  Created by lyl on 2017/3/11.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LrcLabel;
@interface LrcView : UIScrollView

@property (nonatomic, copy) NSString *lrcName;

@property (nonatomic, strong) LrcLabel *lrcLabel;

@property (nonatomic, assign) NSTimeInterval currentTime;
//播放总时长
@property (nonatomic, assign) NSTimeInterval duration;


@end
