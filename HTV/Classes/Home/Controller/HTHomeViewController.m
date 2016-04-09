//
//  HTHomeViewController.m
//  HTV
//
//  Created by 黄韬 on 16/2/21.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import "HTHomeViewController.h"
#import "HTHomeViewCell.h"
#import "HTPlayController.h"


@interface HTHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong) UISegmentedControl *segmented;
/**
 *  显示tabvleview
 */
@property (nonatomic,strong) UITableView * recentView;
@property(nonatomic,strong) UIImageView *emptyView;

@property(nonatomic,strong) NSArray *models;

@property(nonatomic,strong) NSMutableArray *homeDicts;
@property(nonatomic,strong) NSMutableArray *homeOtherDicts;
@property(nonatomic,weak) UIPageControl *pageView;

@end

@implementation HTHomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"HTV";
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSArray *)models
{
    if (_models==nil) {
        _models=[NSArray array];
    }

    return _models;
}

-(NSMutableArray *)homeDicts
{
    if (_homeDicts==nil) {
        _homeDicts=[NSMutableArray array];
        
        NSArray *tmpArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HomeView" ofType:@"plist"]];
        for (NSDictionary *dict in tmpArr) {
            HTHomeViewCellModel *homeModel = [HTHomeViewCellModel modelWithDict:dict];
            [_homeDicts addObject:homeModel];
        }

        
    }

    return _homeDicts;
}

-(NSMutableArray *)homeOtherDicts
{
    if(!_homeOtherDicts)
    {
        _homeOtherDicts=[NSMutableArray array];
        
        NSArray *tmpArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HomeViewOther" ofType:@"plist"]];
        for (NSDictionary *dict in tmpArr) {
            HTHomeViewCellModel *homeModel = [HTHomeViewCellModel modelWithDict:dict];
            [_homeOtherDicts addObject:homeModel];
        }
        
    }
    
    return _homeOtherDicts;

}


-(UIImageView *)emptyView{

    if(_emptyView ==nil)
    {
        _emptyView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me"]];
        _emptyView.frame=CGRectMake(0, HTNavFrame.size.height+55, HTAppWidth, HTAppHeight) ;
    
    }
    return _emptyView;
    
}


-(void) setupUI
{
    //设置SegmentedControl
    UISegmentedControl *segment=[[UISegmentedControl alloc] initWithItems:@[@"最近",@"精选",@"关注"]];
    segment.tintColor=[UIColor whiteColor];
    
    segment.frame=CGRectMake(0,HTNavFrame.size.height+20, HTAppWidth, 35);
    
    //文字设置
    NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
    
    attDic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    attDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [segment setTitleTextAttributes:attDic forState:UIControlStateNormal];
    attDic[NSForegroundColorAttributeName] = [UIColor redColor];
    [segment setTitleTextAttributes:attDic forState:UIControlStateSelected];
    
    segment.selectedSegmentIndex=0;
    self.segmented=segment;
    
    
    [segment addTarget:self action:@selector(segmentedDidClick:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segment];
    
    
    //设置tableview
    self.recentView=[[UITableView alloc] initWithFrame:CGRectNull style:UITableViewStyleGrouped];
    [self setupTableView:self.recentView];
    

}

//初始化tableView
-(void)setupTableView:(UITableView *) tableView
{
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.frame=CGRectMake(0, self.segmented.bounds.size.height+64, HTAppWidth, HTAppHeight);
    self.models=self.homeDicts;
   
    [self.view addSubview:tableView];

}



-(void)segmentedDidClick:(UISegmentedControl *) sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.models=self.homeDicts;
            [self.emptyView removeFromSuperview];
            [self.view addSubview:self.recentView];
            [self.recentView reloadData];
            
            break;
         case 1:
            self.models=self.homeOtherDicts;
            [self.emptyView removeFromSuperview];
            [self.view addSubview:self.recentView];
            [self.recentView reloadData];
            
            break;
        case 2:
            [self.recentView removeFromSuperview];
            [self.view addSubview:self.emptyView];
            
            break;
            
        default:
            break;
    }

}




#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.models.count==0) {
        
        [self.recentView removeFromSuperview];
        [self.view addSubview:self.emptyView];
        
        return 0;
    }
    
    else
    {
        [self.emptyView removeFromSuperview];
        [self.view addSubview:self.recentView];
    
        return self.models.count;
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ReuseId=@"HomeCell";
    HTHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseId];
    if (cell==nil) {
        cell=[HTHomeViewCell homeViewCell];
    }
    
    cell.model=self.models[indexPath.row];
    
    return  cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{

    HTPlayController *play=[[HTPlayController alloc] init];
    play.model=self.models[indexPath.row];
    
    
    /**
     *  modal的方式才可以出发屏幕旋转的相关方法
     */
    //[self.navigationController pushViewController:play animated:YES];
    [self presentViewController:play animated:YES completion:nil];
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIScrollView * scrollView=[[UIScrollView alloc] init];
    scrollView.contentSize=CGSizeMake(HTAppWidth*3, 0);
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    //隐藏水平滚动指示器
    scrollView.showsHorizontalScrollIndicator=NO;
    
    
    
    
    for (int i=0; i<3; i++) {
        UIImageView *imageView=[[UIImageView alloc] init];
        imageView.frame=CGRectMake(i*HTAppWidth, 0, HTAppWidth, 100);
        NSString *imageName=[NSString stringWithFormat:@"%d.jpg",i];
        imageView.image=[UIImage imageNamed:imageName];
        
        [scrollView addSubview:imageView];
    }
    
    UIPageControl *pageView=[[UIPageControl alloc] initWithFrame:CGRectMake(HTAppWidth/2, 180, 0, 0)];
    pageView.numberOfPages=3;
    pageView.userInteractionEnabled=YES;
    pageView.currentPageIndicatorTintColor=[UIColor redColor];
    [pageView addTarget:self action:@selector(pageClick:) forControlEvents:UIControlEventValueChanged];
    self.pageView=pageView;
    [self.view insertSubview:pageView aboveSubview:scrollView];
    
    return scrollView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  100;

}

-(void)pageClick:(UIScrollView *) scrollView
{
    
    //令UIScrollView做出相应的滑动显示
    
    CGRect rect = CGRectMake(self.pageView.currentPage * HTAppWidth, 0, 0 ,0);
    [scrollView scrollRectToVisible:rect animated:YES];

}

//实现UIScrollView的滚动方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算到第几页
    //1.获取滚动的偏移值
    CGFloat offsetX=scrollView.contentOffset.x;
    offsetX=offsetX+(scrollView.frame.size.width*0.5);
    
    
    //2.计算当前滚动到第几页
    int page = offsetX/scrollView.frame.size.width;
    
    //3。设置页码
    self.pageView.currentPage=page;
    
    
}


@end
