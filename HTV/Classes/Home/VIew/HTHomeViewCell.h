//
//  HTHomeViewCell.h
//  HTV
//
//  Created by 黄韬 on 16/3/5.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTHomeViewCellModel.h"

@interface HTHomeViewCell : UITableViewCell


@property(nonatomic,strong) HTHomeViewCellModel * model;

+(instancetype)homeViewCell;

@end
