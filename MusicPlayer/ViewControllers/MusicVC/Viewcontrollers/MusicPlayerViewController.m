//
//  MusicPlayerViewController.m
//  MusicPlayer
//
//  Created by lyl on 2017/3/8.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+Extension.h"
#import "CALayer+Extension.h"
#import "PlayerTool.h"
#import "AudioPlayerTool.h"
#import "MusicModel.h"
#import "macro_define.h"

@interface MusicPlayerViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *albumImg;

@property (nonatomic, strong) IBOutlet UIImageView *singerImg;

@property (nonatomic, strong) IBOutlet UILabel *musicLabel;

@property (nonatomic, strong) IBOutlet UILabel *signerLabel;
//播放时间
@property (nonatomic, strong) IBOutlet UILabel *playTimeLabel;
//歌曲总时间
@property (nonatomic, strong) IBOutlet UILabel *totalTimeLabel;
//进度条
@property (strong, nonatomic) IBOutlet UISlider *slider;
//暂停、播放
@property (strong, nonatomic) IBOutlet UIButton *playAndPasueBtn;

//播放器
@property (nonatomic, strong) AVAudioPlayer * currentPlayer;
//进度条时间
@property (nonatomic, strong) NSTimer *sliderTimer;
//歌词定时器
@property (nonatomic, strong) CADisplayLink *lrcTimer;

/* 歌词 */
@property (strong, nonatomic) IBOutlet UIScrollView *lrcScrollView;

@property (strong, nonatomic) IBOutlet UILabel *lrcLabel;

@end

@implementation MusicPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
    
}

/* 事件处理 */
- (IBAction)playOrPause:(id)sender {
    ((UIButton *)sender).selected = !((UIButton *)sender).selected;
    if (_currentPlayer.isPlaying) {
        [_currentPlayer pause];
        [self removeSlider];
        [_singerImg.layer pauseAni];
    }else {
        [_currentPlayer play];
        [self addSliderTimer];
        [_singerImg.layer resumeAni];
    }
}

- (IBAction)nextMusicClick:(id)sender {
    MusicModel *nextMusic = [PlayerTool nextMusic];
    [self playWithMusic:nextMusic];
}

- (IBAction)lastMusicClick:(id)sender {
    MusicModel *lastMusic = [PlayerTool lastMusic];
    [self playWithMusic:lastMusic];
}

- (IBAction)sliderValueChange:(id)sender {
    
    _playTimeLabel.text = [NSString stringWithTime:_slider.value * _currentPlayer.duration];
//    NSLog(@"%@",[NSString stringWithTime:_slider.value * _currentPlayer.duration]);
}

- (IBAction)touchDownSlider:(id)sender {
    [self removeSlider];
}

- (IBAction)endTouchSlider:(id)sender {
    _currentPlayer.currentTime = _slider.value * _currentPlayer.duration;
    [self addSliderTimer];
}

- (IBAction)sliderClick:(UITapGestureRecognizer *)sender
{
    // 获取点击到的点
    CGPoint point = [sender locationInView:sender.view];
    // 计算占全部长度的比例
    CGFloat num = point.x / _slider.frame.size.width;
    // 设置当前需要播放时间
    _currentPlayer.currentTime = num * _currentPlayer.duration;
    // 更新 slider
    [self updateSliderInfo];
}

#pragma mark ---UI
- (void)setUI
{
    [self.slider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb@2x.png"] forState:UIControlStateNormal];
    _lrcScrollView.contentSize = CGSizeMake(ScreenWidth *2, 0);
    [self playMusic];
}

#pragma mark ---歌手图片旋转动画
- (void)addSingerImgAnimation
{
    CABasicAnimation *rotateAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAni.fromValue = @(0);
    rotateAni.toValue = @(M_PI *2);
    rotateAni.repeatCount = NSIntegerMax;
    rotateAni.duration = 36;
    [_singerImg.layer addAnimation:rotateAni forKey:nil];
}

#pragma mark ---头像圆角设置
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _singerImg.layer.cornerRadius  = _singerImg.bounds.size.width *0.5;
    _singerImg.layer.masksToBounds = YES;
    _singerImg.layer.borderColor   = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1.0]);
    _singerImg.layer.borderWidth   = 5;
}

#pragma mark ---播放音乐
- (void)playMusic
{
    //获取当前歌曲
    MusicModel *musicObj = [PlayerTool musicObj];
    
    //设置界面
    _albumImg.image   = [UIImage imageNamed:musicObj.img];
    _singerImg.image  = [UIImage imageNamed:musicObj.img];
    _musicLabel.text  = musicObj.song;
    _signerLabel.text = musicObj.singer;
    
    AVAudioPlayer *currentMusic = [AudioPlayerTool playingMusicWithFileName:musicObj.fileName];
    _playTimeLabel.text = [NSString stringWithTime:currentMusic.currentTime];
    _totalTimeLabel.text = [NSString stringWithTime:currentMusic.duration];
    _currentPlayer = currentMusic;
    
    _playAndPasueBtn.selected = currentMusic.isPlaying;
    
    [self addSingerImgAnimation];
    [self removeSlider];
    [self addSliderTimer];
    
    [self addSliderTimer];
    
}

#pragma mark ---进度条处理: 添加、更新、删除
- (void)addSliderTimer
{
    [self updateSliderInfo];
    _sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateSliderInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_sliderTimer forMode:NSRunLoopCommonModes];
    
}

- (void)updateSliderInfo
{
    //更新播放时间
    _playTimeLabel.text = [NSString stringWithTime:_currentPlayer.currentTime];
    //更新滑动条
    _slider.value = _currentPlayer.currentTime / _currentPlayer.duration;
//    NSLog(@"----%f\n",_slider.value);
    if (_slider.value > nextSecond) {
        [self removeSlider];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self nextMusicClick:nil];
        });
    }
    
}

- (void)removeSlider
{
    [_sliderTimer invalidate]; //时间失效
    _sliderTimer = nil;
}

#pragma mark ---播放指定音乐
- (void)playWithMusic:(MusicModel *)music
{
    MusicModel *playingMusicObj = [PlayerTool musicObj];
    [AudioPlayerTool stopMusicWithMusicFileName:playingMusicObj.fileName];
    
    [PlayerTool setUpPlayingMusic:music];
    [self playMusic];
}

#pragma mark ---scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offcetPoint = scrollView.contentOffset;
    
    CGFloat alpha = 1 - offcetPoint.x / ScreenWidth;
    
    _singerImg.alpha = alpha;
    _lrcLabel.alpha = alpha;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
