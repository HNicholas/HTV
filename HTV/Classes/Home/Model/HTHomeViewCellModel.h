//
//  HTHomeViewCellModel.h
//  HTV
//
//  Created by 黄韬 on 16/3/5.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTHomeViewCellModel : NSObject

@property(nonatomic,copy) NSString * contentImageName;

@property(nonatomic,copy) NSString * iconImageName;

@property(nonatomic,copy) NSString * userName;

@property(nonatomic,copy) NSString * contentName;

-(instancetype) initWithDict:(NSDictionary *) dict;
+(instancetype) modelWithDict:(NSDictionary *) dict;



@end
