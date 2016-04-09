//
//  HTHomeViewCellModel.m
//  HTV
//
//  Created by 黄韬 on 16/3/5.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import "HTHomeViewCellModel.h"

@implementation HTHomeViewCellModel


-(instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;

}


+(instancetype)modelWithDict:(NSDictionary *)dict{

    return  [[self alloc] initWithDict:dict];

}


@end
