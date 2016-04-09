//
//  HTLeftMenu.m
//  HTV
//
//  Created by 黄韬 on 16/2/21.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import "HTLeftMenu.h"
#import "HTInfoBtnView.h"

@interface HTLeftMenu()

/**
 *  选中的Button
 */
@property(nonatomic,weak) UIButton * selectBtn;

@end

@implementation HTLeftMenu

#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        [self setupBtnWithIcon:@"handShake.png" title:@"首页"];
        [self setupBtnWithIcon:@"IDinfo.png" title:@"添加好友"];
        [self setupBtnWithIcon:@"MoreAbout.png" title:@"关于HTV"];
        [self setupBtnWithIcon:@"MorePush.png" title:@"设置"];
        [self setupInfoBtn];
        
    }

    return self;
}



-(void)setupInfoBtn
{
    HTInfoBtnView *btnView=[HTInfoBtnView InfoBtn];
    btnView.UserIcon.image=[UIImage imageNamed:@"me"];
    [self addSubview:btnView];

}


/**
 *  添加按钮
 *
 *  @param icon  图标
 *  @param title 标题
 */
- (UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = self.subviews.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    // 设置图片和文字
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置按钮选中的背景
    [btn setBackgroundColor:[UIColor blackColor]];
    
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    // 设置高亮的时候不要让图标变色
    btn.adjustsImageWhenHighlighted = NO;
    
    // 设置按钮的内容左对齐
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    long btnCount = self.subviews.count;
    CGFloat btnW = self.width;
    CGFloat btnH = self.height / btnCount;
    for (int i = 0; i<btnCount; i++) {
        
        if ([self.subviews[i] isKindOfClass:[HTInfoBtnView class]]) {
            HTInfoBtnView *infoBtn=self.subviews[i];
            
            infoBtn.frame=CGRectMake(0, 15, btnW, 100);
        }
        else
        {
            UIButton *btn = self.subviews[i];
            btn.width = btnW;
            btn.height = btnH;
            btn.y = i * btnH+120;
        }
    }
        
}

-(void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(leftMenuViewButtonClcikFrom:to:)]) {
        [self.delegate leftMenuViewButtonClcikFrom:self.selectBtn.tag to:button.tag];
    }
    
    button.selected=YES;
    self.selectBtn.selected=NO;
    self.selectBtn=button;
    

    
}

-(void)setDelegate:(id<HTLeftMenuDelegate>)delegate
{
    _delegate=delegate;
    [self buttonClick:self.subviews[0]];
    
}



@end

