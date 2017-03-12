//
//  LrcTableViewCell.m
//  MusicPlayer
//
//  Created by lyl on 2017/3/10.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "LrcTableViewCell.h"
#import "macro_define.h"
#import "LrcLabel.h"
@implementation LrcTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        LrcLabel *label = [[LrcLabel alloc] init];
        label.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        _lrcLabel = label;
        [self.contentView addSubview:_lrcLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (LrcTableViewCell *)lrcCellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"lrcCell";
    LrcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[LrcTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}


@end
