//
//  MusicModel.h
//  MusicPlayer
//
//  Created by lyl on 2017/3/8.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject

@property (nonatomic, copy) NSString *song;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *lrcName;
@property (nonatomic, copy) NSString *singer;
@property (nonatomic, copy) NSString *img;

@end
