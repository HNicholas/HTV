//
//  HTTestMan.m
//  HTV
//
//  Created by 黄韬 on 16/2/21.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import "HTTestMan.h"

@implementation HTTestMan

-(instancetype)init
{
    id test=[super init];
    NSLog(@"+++%@",[test class]);
    
    if  (self = [super init])
    {
        NSLog(@"AAAA%@",[self class]);
    
    }
    
    
    return  self;
}

@end
