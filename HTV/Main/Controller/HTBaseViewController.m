//
//  HTBaseViewController.m
//  HTV
//
//  Created by 黄韬 on 16/2/24.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import "HTBaseViewController.h"

@interface HTBaseViewController ()
/**
 *  遮盖图片
 */
@property(nonatomic,weak) UIButton *cover;

@end

@implementation HTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupNavItem
{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_category_-1"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarBtnClick)] ;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MoreHelp"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnClick)];
    
    self.view.backgroundColor=HTBackgroundGrayColor;

}


#pragma mark --导航栏左右按钮点击
-(void)leftBarBtnClick
{
    //添加一个遮盖
   UIButton *cover=[[UIButton alloc] init];
    cover.frame=self.view.bounds;
    [cover addTarget:self action:@selector(coveDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.cover=cover;
    [self.navigationController.view addSubview:self.cover];
    
    
    //缩放比例
    CGFloat zoomScale=(HTAppHeight-HTScaleTopMargin*2)/HTAppHeight;
    
    //x移动距离
    CGFloat moveX=HTAppWidth-HTAppWidth*HTZoomScaleRight;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGAffineTransform transform=CGAffineTransformMakeScale(zoomScale, zoomScale);
    
        self.navigationController.view.transform=CGAffineTransformTranslate(transform, moveX, 0);
        
    }];
    
    
    
}

-(void)rightBarBtnClick
{


}

-(void)coveDidClick
{
    [UIView animateWithDuration:0.1 animations:^{
        self.navigationController.view.transform=CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [self.cover removeFromSuperview];
    }];

}



@end
