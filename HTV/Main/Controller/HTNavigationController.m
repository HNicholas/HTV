//
//  HTNavigationController.m
//  HTV
//
//  Created by 黄韬 on 16/2/21.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import "HTNavigationController.h"

@interface HTNavigationController ()



@end

@implementation HTNavigationController


+(void)initialize
{
    UIBarButtonItem *item =[UIBarButtonItem appearance];
    item.tintColor=[UIColor redColor];
    
    UINavigationBar *bar=[UINavigationBar appearance];
    bar.barStyle=UIBarStyleDefault;
    bar.backgroundColor=[UIColor clearColor];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
