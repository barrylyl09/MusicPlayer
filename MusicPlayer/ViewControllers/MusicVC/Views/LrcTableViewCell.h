//
//  LrcTableViewCell.h
//  MusicPlayer
//
//  Created by lyl on 2017/3/10.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LrcLabel;

@interface LrcTableViewCell : UITableViewCell

@property (nonatomic, weak) LrcLabel *lrcLabel;

//set cell
+ (LrcTableViewCell *)lrcCellWithTableView:(UITableView *)tableView;

@end
