//
//  macro_define.h
//  MusicPlayer
//
//  Created by lyl on 2017/3/8.
//  Copyright © 2017年 lyl. All rights reserved.
//

#ifndef macro_define_h
#define macro_define_h

#define AppStatusHeight     (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
#define ScreenHeight        [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth         [[UIScreen mainScreen] bounds].size.width
#define HotStatusHeight             20
#define StatueBarHeight             20
#define NavBarHeight_Narmal         44
#define NavBarHeight                64
#define TabbarHeight                49  //49
#define IsHotSpotConnected  (AppStatusHeight == HotStatusHeight + StatueBarHeight ? YES:NO)

#endif /* macro_define_h */
