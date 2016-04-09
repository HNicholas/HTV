//
//  HTSetupCell.h
//  HTV
//
//  Created by 黄韬 on 16/3/10.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTSetupItem.h"

@interface HTSetupCell : UITableViewCell

@property(nonatomic,strong) HTSetupItem *item;

+(instancetype) cellWithTableView:(UITableView *) tableView;


@end
