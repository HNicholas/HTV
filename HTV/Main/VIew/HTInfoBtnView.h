//
//  HTInfoBtnView.h
//  HTV
//
//  Created by 黄韬 on 16/2/21.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HTInfoBtnViewDelegate <NSObject>

-(void)viewDidClick;

@end

@interface HTInfoBtnView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *UserIcon;
@property (weak, nonatomic) IBOutlet UILabel *UserName;

@property (weak, nonatomic) IBOutlet UILabel *UserId;
+(instancetype) InfoBtn;


@property(nonatomic,weak) id<HTInfoBtnViewDelegate> delegate;


@end
