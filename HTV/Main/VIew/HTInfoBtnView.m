//
//  HTInfoBtnView.m
//  HTV
//
//  Created by 黄韬 on 16/2/21.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import "HTInfoBtnView.h"
#import "HTSetupViewController.h"

@interface HTInfoBtnView ()

@end

@implementation HTInfoBtnView

+(instancetype)InfoBtn
{
    return  [[[NSBundle mainBundle] loadNibNamed:@"HTInfoBtnView" owner:nil options:nil] lastObject];

}

-(void)awakeFromNib
{
    //圆形头像
    self.UserIcon.layer.cornerRadius=self.UserIcon.frame.size.width/2;
    self.UserIcon.layer.masksToBounds=YES;
    self.UserIcon.layer.shouldRasterize=YES;
    self.UserIcon.layer.borderColor=[UIColor whiteColor].CGColor;
    self.UserIcon.layer.borderWidth=2;
    
    
    self.UserName.text=@"用户名";
    //给头像view添加一个手势
    [self addGestureRecognizer];
    
    
}

-(void) addGestureRecognizer
{
    self.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo)];
    
    [self addGestureRecognizer:tapGesture];

}

-(void)Actiondo
{
  if ([self.delegate respondsToSelector:@selector(userIconViewDidClick)])
  {
      [self.delegate userIconViewDidClick];
  
  }
      

}


@end
