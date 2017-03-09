//
//  main.m
//  MusicPlayer
//
//  Created by lyl on 2017/3/8.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

//有100栈灯，编号1-100, 第一下红，第二绿，第三下关。第一次所有开关。第二下按下倍数是2的开关，第三次按倍数为3.第n 倍数为 n。第n 次按有几个红灯。
bool red(int n, int i)
{
    int Count = 0;
    for (int idx = 1; idx < n; idx++) {
        if (i%idx == 0) Count++;
    }
    
    if (Count%3 == 1) return YES;
    
    return NO;
}
//n: 按的次数， i 灯总数
int getRedNum(int n, int i)
{
    int redNum = 0;
    for ( int idx = 1; idx < i; idx++) {
        if(red(n, idx)) redNum++;
    }
    
    return redNum;
}
