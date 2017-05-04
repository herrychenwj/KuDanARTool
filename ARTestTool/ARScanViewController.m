//
//  ARScanViewController.m
//  ARTestTool
//
//  Created by 陈文娟 on 2017/5/4.
//  Copyright © 2017年 陈文娟. All rights reserved.
//

#import "ARScanViewController.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "RadarView.h"

@interface ARScanViewController ()<AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation ARScanViewController
{
    AppDelegate * appDelegate;
    AVAudioPlayer *avAudioPlayer;
    AVAudioPlayer *avAudioPlayer2;
    UIView *_circleView;
    bool showAnimal;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    showAnimal = YES;
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    //从budle路径下读取音频文件　　轻音乐 - 萨克斯回家 这个文件名是你的歌曲名字,mp3是你的音频格式
    NSString *string = [[NSBundle mainBundle] pathForResource:@"btn_click" ofType:@"mp3"];
    //把音频文件转换成url格式
    NSURL *url = [NSURL fileURLWithPath:string];
    //初始化音频类 并且添加播放文件
    avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //设置代理
    avAudioPlayer.delegate = self;
    
    
    NSString *normalstring = [[NSBundle mainBundle] pathForResource:@"scan_voice" ofType:@"mp3"];
    //把音频文件转换成url格式
    avAudioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:normalstring] error:nil];
    avAudioPlayer.delegate = self;

    
}

-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

#pragma mark === 永久闪烁的动画 ======
-(CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupContent
{
    ARImageTrackerManager *trackerManager = [ARImageTrackerManager getInstance];
    
    // Initialise the image tracker.
    [trackerManager initialise];
    
    // Create a trackable from a bundled file. Give it a unique name which we can use to locate it later.
    ARImageTrackable *imgTrackable = [[ARImageTrackable alloc] initWithImage:appDelegate.currentImg name:appDelegate.imgName];
    
    // Add this new trackable to the tracker.
    [trackerManager addTrackable:imgTrackable];
    ARImageTrackable *startTrackimg = [trackerManager findTrackableByName:appDelegate.imgName];
    
    [startTrackimg addTrackingEventTarget:self action:@selector(textTracking:) forEvent:ARImageTrackableEventDetected];
    [startTrackimg addTrackingEventTarget:self action:@selector(textLost:) forEvent:ARImageTrackableEventLost];
    
    [self startAnimal];
    [avAudioPlayer2 play];
    
}

-(void)startAnimal
{
    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
    CGFloat sh = [UIScreen mainScreen].bounds.size.height;
    dispatch_source_t disTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(disTimer, dispatch_walltime(NULL, 0), 1ull * NSEC_PER_SEC, 0ull * NSEC_PER_SEC);
    dispatch_source_set_event_handler(disTimer, ^{
        RadarView *rv = [[RadarView alloc] initWithFrame:CGRectMake(0 , 0, sw / 2, sw / 2)];
        if (showAnimal) {
            [rv animationWithDuraton:4.0];
            rv.center = CGPointMake(sw / 2, sh / 2);
            [self.view addSubview:rv];
        }
        else {
            dispatch_source_cancel(disTimer);
        }
    });
//    dispatch_source_set_cancel_handler(disTimer, ^{
//        NSLog(@"timer cancle");
//        sender.enabled = YES;
//        [sender setTitle:@"前方500米处有厕所" forState:UIControlStateNormal];
//    });
    dispatch_resume(disTimer);

}


- (void)textTracking:(ARImageTrackable *)trackable
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.showLabel.text = trackable.name;
        self.showLabel.hidden = NO;
        showAnimal = NO;
        //
        [avAudioPlayer2 stop];
        [avAudioPlayer play];
    });
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [avAudioPlayer stop];
    avAudioPlayer = nil;
    [avAudioPlayer2 stop];
    avAudioPlayer2 = nil;
}

- (void)textLost:(ARImageTrackable *)trackable
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.showLabel.text = @"";
        self.showLabel.hidden = YES;
        showAnimal = YES;
        [self startAnimal];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
