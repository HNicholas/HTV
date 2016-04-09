//
//  HTSetupGroup.h
//  HTV
//
//  Created by 黄韬 on 16/3/10.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTSetupItem.h"


@interface HTSetupGroup : NSObject

//标题
@property(nonatomic,copy) NSString * headerTitle;
@property(nonatomic,copy) NSString *footerTitle;


//当前分组中所有行的数据
@property(nonatomic,strong) NSArray *items;

@end
