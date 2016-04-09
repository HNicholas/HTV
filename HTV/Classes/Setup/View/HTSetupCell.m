//
//  HTSetupCell.m
//  HTV
//
//  Created by 黄韬 on 16/3/10.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import "HTSetupCell.h"


@interface HTSetupCell ()

@property(nonatomic,strong) UIImageView *arrowIv;
@property(nonatomic,strong) UISwitch *switchBtn;
@property(nonatomic,strong) UILabel *labelView;


@end


@implementation HTSetupCell


-(instancetype)init
{
    if (self=[super init]) {
        UIView *selView=[[UIView alloc] init];
        
        selView.backgroundColor=[UIColor colorWithRed:232.0/255.0  green:228.0/255.0 blue:209.0/255.0 alpha:1];
        self.selectedBackgroundView=selView;
        
        //2.设置cell默认状态的背景颜色
        UIView *norView=[[UIView alloc] init];
        norView.backgroundColor=[UIColor whiteColor];
        self.backgroundView=norView;
        
        //3.清空子视图的背景颜色
        self.textLabel.backgroundColor=[UIColor clearColor];
        self.detailTextLabel.backgroundColor=[UIColor clearColor];
                
            }
    return self;

}

-(UIImageView *)arrowIv
{
    if (_arrowIv==nil) {
        _arrowIv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrowIv;
    
}

-(UISwitch *)switchBtn
{
    if(_switchBtn==nil)
    {
        _switchBtn = [[UISwitch alloc] init];
        //监听开关的改变
        [_switchBtn addTarget:self action:@selector(switchBtnChange) forControlEvents:UIControlEventValueChanged];
        
    }
    
    return _switchBtn;
    
}
-(UILabel *)labelView
{
    if (_labelView==nil)
    {
        _labelView=[[UILabel alloc] init];
    }
    
    return _labelView;
    
}


-(void)switchBtnChange
{
    if (!self.switchBtn.isOn) {
        NSLog(@"开关关闭");
    }
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier=@"tableCell";
    
    HTSetupCell *cell =(HTSetupCell *) [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    
    if (cell==nil) {
        cell = [[HTSetupCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        
    }
    
    
    return  cell;

}

-(void)setItem:(HTSetupItem *)item
{
    _item=item;
    //设置数据
    self.textLabel.text=item.title;
    self.imageView.image=[UIImage imageNamed:_item.icon];
    
    if (_item.type==HTSettingItemSwitch) {
        self.accessoryView=self.switchBtn;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    else if(_item.type==HTSettingItemArrow)
    {
        self.accessoryView=self.arrowIv;
        self.selectionStyle=UITableViewCellSelectionStyleBlue;
    }
    else
    {
        self.accessoryView=nil;
        
    }
    


}


@end
