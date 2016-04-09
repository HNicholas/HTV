//
//  HTMainViewController.m
//  HTV
//
//  Created by 黄韬 on 16/2/21.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import "HTMainViewController.h"
#import "HTLeftMenu.h"
#import "UIBarButtonItem+Extension.h"
#import "HTHomeViewController.h"
#import "HTAddFriendController.h"
#import "HTNavigationController.h"
#import "HTSetupViewController.h"


@interface HTMainViewController ()<HTLeftMenuDelegate>


@property(nonatomic,strong) HTLeftMenu *leftMenu;

@end

@implementation HTMainViewController


#pragma  mark - 懒加载
-(HTLeftMenu *)leftMenu
{
    if (_leftMenu == nil) {
        HTLeftMenu *leftMenu=[[HTLeftMenu alloc] init];
        leftMenu.delegate=self;
        _leftMenu=leftMenu;
    }
    return _leftMenu;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建子控制器
    [self setupChildControllers];
    
    
    //设置左边菜单栏
   [self setupLeftMenu];
    
    
}

-(void)setupChildControllers
{
    //首页
    HTHomeViewController *homeController=[[HTHomeViewController alloc] init];
    [self setupVc:homeController title:@"HTV"];
    
    //添加好友
    HTAddFriendController *addFriendController=[[HTAddFriendController alloc] init];
    [self setupVc:addFriendController title:@"添加好友"];
    
    //关于
    HTBaseViewController *base=[[HTBaseViewController alloc] init];
    [self setupVc:base title:nil];
    
    //设置
    HTSetupViewController *setup=[[HTSetupViewController alloc] init];

    [self setupVc:setup title:@"设置"];
    
    
    
    

}

-(void) setupLeftMenu
{
    self.leftMenu.frame=CGRectMake(0, 0, self.view.width*0.6, self.view.height);
    [self.view insertSubview:self.leftMenu atIndex:1];

    

}

/**
 *  初始化一个控制器
 *
 *  @param vc      需要初始化的控制器
 *  @param title   控制器的标题
 */
- (void)setupVc:(HTBaseViewController *)vc title:(NSString *)title
{
    //包装一个导航控制器
    HTNavigationController *nav = [[HTNavigationController alloc] initWithRootViewController:vc];
    // 让newsNav成为self（HMMainViewController）的子控制器，能保证：self在，newsNav就在
    // 如果两个控制器互为父子关系，那么它们的view也应该互为父子关系
    [self addChildViewController:nav];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - HTLeftMenuDelegate

-(void)leftMenuViewButtonClcikFrom:(int)fromIndex to:(int)toIndex
{
    //1.移除旧控制器的view
    [self.childViewControllers[fromIndex].view removeFromSuperview];
   
    //2.显示新控制器的view
    HTNavigationController *newNav=self.childViewControllers[toIndex];
    // 设置新控制的transform跟旧控制器一样
    newNav.view.transform=self.childViewControllers[fromIndex].view.transform;
    
    
    [self.view addSubview:newNav.view];
    
    //清空transform
    [UIView animateWithDuration:0.3 animations:^{
        newNav.view.transform=CGAffineTransformIdentity;
    }];
    
    

}



@end
