//
//  HTSetupViewController.m
//  HTV
//
//  Created by 黄韬 on 16/3/5.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import "HTSetupViewController.h"
#import "HTSetupItem.h"
#import "HTSetupGroup.h"
#import "HTSetupCell.h"
#import "HTHomeViewController.h"
#import  "MBProgressHUD.h"



@interface HTSetupViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)  UITableView * tableView;

@property(nonatomic,strong) NSMutableArray *groups;

@end

@implementation HTSetupViewController

-(UITableView *)tableView{
    if (_tableView==nil) {
        
        
        _tableView=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    
    return _tableView;
    
}

-(NSMutableArray *)groups
{
    if (_groups==nil) {
        _groups=[NSMutableArray array];
        
        [self addGroup0];
        [self addGroup1];
        
        
    }

    return _groups;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"设置";
    self.tableView.scrollEnabled=NO;
    self.navigationItem.rightBarButtonItem=nil;
    // Do any additional setup after loading the view.
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setupTableView
{
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorInset=UIEdgeInsetsZero;
    //self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    
}

-(void)addGroup0
{
    HTSetupItem *arrowItem=[[HTSetupItem alloc] initWithIcon:@"CellArrow" title:@"分享" destClass:nil type:HTSettingItemArrow];
    
    HTSetupItem *switchUtem=[[HTSetupItem alloc] initWithIcon:@"handShake" title:@"开关" destClass:nil type:HTSettingItemSwitch];
    
    HTSetupItem *labelItem=[[HTSetupItem alloc] initWithIcon:nil title:@"退出登录" destClass:nil type:HTSettingItemLabel];
    labelItem.option=^{
    
        [self.navigationController.view removeFromSuperview];
    };
    
    HTSetupGroup *group=[[HTSetupGroup alloc] init];
    group.items=@[arrowItem,switchUtem,labelItem];
    
    [self.groups addObject:group];
    
}

-(void)addGroup1
{
    HTSetupItem *labelItem0=[[HTSetupItem alloc] initWithIcon:nil title:@"测试1" destClass:nil type:HTSettingItemLabel];
    HTSetupItem *labelItem1=[[HTSetupItem alloc] initWithIcon:nil title:@"测试2" destClass:nil type:HTSettingItemLabel];
    labelItem1.option=^{
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
    };
    HTSetupGroup *group=[[HTSetupGroup alloc] init];
    group.items=@[labelItem0,labelItem1];
    
    [self.groups addObject:group];

}



#pragma mark -- TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return self.groups.count;
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    HTSetupGroup *group=self.groups[section];
    return group.items.count;


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTSetupCell *cell=[HTSetupCell cellWithTableView:tableView];
    
    HTSetupGroup *group=self.groups[indexPath.section];
    cell.item=group.items[indexPath.row];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HTSetupGroup *group=self.groups[indexPath.section];
    HTSetupItem *item=group.items[indexPath.row];
    
    if (item.option!=nil) {
        item.option();
    }
    //创建目标控制器并添加到栈中
    if (item.destVc!=nil) {
        
        UIViewController *vc=[[item.destVc alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }


}



@end
