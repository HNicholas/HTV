//
//  HTSetupItem.m
//  HTV
//
//  Created by 黄韬 on 16/3/10.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import "HTSetupItem.h"

@implementation HTSetupItem

-(instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)desrVc type:(HTSettingItemType)type
{
    if (self=[super init]) {
        
        self.title=title;
        self.icon=icon;
        self.destVc=desrVc;
        self.type=type;
        
    }
    
    return self;

}

@end
