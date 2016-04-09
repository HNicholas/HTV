//
//  HTSetupItem.h
//  HTV
//
//  Created by 黄韬 on 16/3/10.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^optionBlock)();//定义block类型

typedef enum{
    HTSettingItemSwitch,
    HTSettingItemArrow,
    HTSettingItemLabel
    
} HTSettingItemType;


@interface HTSetupItem : NSObject

@property(nonatomic,copy) NSString *icon;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,assign) Class destVc;
@property(nonatomic,assign) HTSettingItemType type;


//定义block保存将来要执行的代码
@property(nonatomic,copy) optionBlock option;

-(instancetype) initWithIcon:(NSString *)icon title:(NSString *) title destClass:(Class) desrVc type:(HTSettingItemType) type;

@end
