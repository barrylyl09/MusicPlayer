//
//  LrcView.m
//  MusicPlayer
//
//  Created by lyl on 2017/3/11.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "LrcView.h"
#import "LrcTableViewCell.h"
#import "LrcModel.h"
#import "LrcLabel.h"
#import "LrcTool.h"
#import "macro_define.h"
#import <objc/runtime.h>

@interface LrcView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
/** 歌词数组 */
@property(nonatomic,strong) NSArray *lrcArr;
/** 当前歌词的下标 */
@property (nonatomic,assign) NSInteger currentIdx;

@end

@implementation LrcView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initWithTableView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initWithTableView];
    }
    
    return self;
}


- (void)initWithTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self addSubview:tableView];
    _tableView = tableView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _tableView.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - 280);
    
    // 2.改变tableView属性
    _tableView.backgroundColor = [UIColor clearColor];
    // 去掉cell之间的线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 40;
    _tableView.contentInset = UIEdgeInsetsMake(self.tableView.bounds.size.height * 0.5, 0, self.tableView.bounds.size.height * 0.5, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lrcArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LrcTableViewCell *cell = [LrcTableViewCell lrcCellWithTableView:tableView];
    
    if (_currentIdx == indexPath.row) {
        cell.lrcLabel.font = [UIFont systemFontOfSize:20];
    } else {
        cell.lrcLabel.font = [UIFont systemFontOfSize:14];
        cell.lrcLabel.progress = 0;
    }
    
    // 获得当前播放的歌曲歌词模型
    LrcModel *lrcObj = _lrcArr[indexPath.row];
    
    cell.lrcLabel.text = lrcObj.lrcText;
    
    return cell;
}

- (void)setLrcName:(NSString *)lrcName
{
    // 0.更新行数
    _currentIdx = 0;
    
    // 1. 记录歌词名
    _lrcName = lrcName;
    // 解析歌词 使用自己创建歌词解析工具
    _lrcArr = [LrcTool lrcToolWithLrcName:lrcName];
    
    LrcModel *lrcObj = _lrcArr[0];
    _lrcLabel.text = lrcObj.lrcText;
    
    
    // 刷新表格
    [_tableView reloadData];
}

- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    _currentTime = currentTime;
    
    for (int idx = 0; idx < _lrcArr.count; idx++) {
        LrcModel *currentLrcObj = _lrcArr[idx];
        NSInteger nextIdx = idx + 1;
        LrcModel *nextLrcObj = nil;
        if (nextIdx < _lrcArr.count) {
            nextLrcObj = _lrcArr[nextIdx];
        }
        
        if (_currentIdx != idx && currentTime >= currentLrcObj.time && currentTime < nextLrcObj.time) {
            _lrcLabel.text = currentLrcObj.lrcText;
            
            //歌词位于屏幕正中
            NSIndexPath *idxPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [_tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
            // 记录上一句位置，当移动到下一句时，上一句和当前这一句都需要进行更新行
            NSIndexPath *lastPath = [NSIndexPath indexPathForRow:_currentIdx inSection:0];
            // 记录当前播放的下标。下次来到这里，currentIndex指的就是上一句
            _currentIdx = idx;
            
            [self.tableView reloadRowsAtIndexPaths:@[idxPath,lastPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        if (_currentIdx == idx) {
            // 获取播放速度 = 已经播放的时间 / 播放整句需要的时间
            CGFloat progress = (currentTime - currentLrcObj.time) / (nextLrcObj.time - currentLrcObj.time);
            // 获取当前行数的cell
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            LrcTableViewCell *lrccell = [self.tableView cellForRowAtIndexPath:indexPath];
            lrccell.lrcLabel.progress = progress;
            _lrcLabel.progress = progress;
        }
    }
}


@end
