//
//  HTLeftMenu.h
//  HTV
//
//  Created by 黄韬 on 16/2/21.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"


@protocol HTLeftMenuDelegate <NSObject>

@required
-(void)leftMenuViewButtonClcikFrom:(int )fromIndex to:(int)toIndex;


@end


@interface HTLeftMenu : UIView

@property(nonatomic,weak) id<HTLeftMenuDelegate> delegate;

@end
