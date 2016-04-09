//
//  HTPlayController.m
//  HTV
//
//  Created by 黄韬 on 16/3/6.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import "HTPlayController.h"
#import "DanmakuView.h"

@interface HTPlayController ()<DanmakuDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *playImageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

 @property(strong,nonatomic)  UISlider *slider;
//弹幕view
@property(strong,nonatomic) DanmakuView * danmakuView;

@property(strong,nonatomic) NSTimer *timer;

@end

@implementation HTPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //屏幕旋转
    //self.view.transform=CGAffineTransformMakeRotation(M_PI_2);

    self.navigationController.navigationBar.hidden = YES;
    self.contentLabel.text=self.model.contentName;
    
    [self setupPlayer];
}




#pragma mark - 按钮点击方法调用
- (IBAction)exitOnClick:(id)sender {
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"是否要离开" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //创建按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
        self.navigationController.navigationBar.hidden = NO;

    }];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)onTimeCount
{
    _slider.value+=0.1/120;
    if (_slider.value>120.0) {
        _slider.value=0;
    }
}

- (IBAction)playBtnClick:(id)sender {
    if (!self.playButton.selected) {
        self.playButton.selected=YES;
        if (self.danmakuView.isPrepared) {
            if (!_timer) {
                _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimeCount) userInfo:nil repeats:YES];
            }
            
            [_danmakuView start];
        }

    }
    else
    {
        self.playButton.selected=NO;
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
       

        [_danmakuView pause];
    }
    
}

- (IBAction)sendBtnClick:(id)sender {
    
    int time = ([self danmakuViewGetPlayTime:nil]+1)*1000;
    int type = rand()%3;
    NSString *pString = [NSString stringWithFormat:@"%d,%d,1,00EBFF,125", time, type];
   // NSString *mString = self.inputField.text;
    NSString *mString=@"test";
    DanmakuSource *danmakuSource = [DanmakuSource createWithP:pString M:mString];
    [self.danmakuView sendDanmakuSource:danmakuSource];

    
}

-(void) setupPlayer
{

    NSMutableArray *array=[[NSMutableArray alloc] initWithCapacity:6];
   
    NSString *imageName;
    
    for (int i=0; i<6; i++) {
        
        imageName=[NSString stringWithFormat:@"%d.jpg", i];
        UIImage *image=[UIImage imageNamed:imageName];
        
        [array addObject:image];
        
    }
    
    self.playImageView.animationImages=array;
    self.playImageView.animationDuration=20;
    [self.playImageView startAnimating];
    
    //弹幕设置
    
    self.inputField.delegate=self;
    CGRect rect =  CGRectMake(0, 2, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-4);
    DanmakuConfiguration *configuration = [[DanmakuConfiguration alloc] init];
    configuration.duration = 6.5;
    configuration.paintHeight = 21;
    configuration.fontSize = 17;
    configuration.largeFontSize = 19;
    configuration.maxLRShowCount = 30;
    configuration.maxShowCount = 45;
   _danmakuView = [[DanmakuView alloc] initWithFrame:rect Configuration:configuration];
    _danmakuView.delegate = self;
    [self.view insertSubview:self.danmakuView aboveSubview:self.playImageView];
    
    
    NSString *danmakufile = [[NSBundle mainBundle] pathForResource:@"danmakufile" ofType:nil];
    NSArray *danmakus = [NSArray arrayWithContentsOfFile:danmakufile];
    [_danmakuView prepareDanmakus:danmakus];
}


#pragma mark --弹幕delegate
- (float)danmakuViewGetPlayTime:(DanmakuView *)danmakuView
{
    return _slider.value*120.0;

}
- (BOOL)danmakuViewIsBuffering:(DanmakuView *)danmakuView
{
    return NO;
}

- (void)danmakuViewPerpareComplete:(DanmakuView *)danmakuView
{
    [_danmakuView start];
    NSLog(@"Danmu start");
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField  {
    
    [self.inputField  resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text=nil;
   

}

- (BOOL) shouldAutorotate
{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}


@end
