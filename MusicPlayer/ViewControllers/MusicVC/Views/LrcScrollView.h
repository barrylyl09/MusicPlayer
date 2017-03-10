//
//  LrcScrollView.h
//  MusicPlayer
//
//  Created by lyl on 2017/3/10.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LrcLabel;

@interface LrcScrollView : UIScrollView

@property (nonatomic, copy) NSString *lrcName;

@property (nonatomic, weak) LrcLabel *lrcLabel;

@property (nonatomic, assign) NSTimeInterval currentTime;

@property (nonatomic, assign) NSTimeInterval duration;

@end
