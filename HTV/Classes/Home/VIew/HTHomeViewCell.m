//
//  HTHomeViewCell.m
//  HTV
//
//  Created by 黄韬 on 16/3/5.
//  Copyright © 2016年 黄韬. All rights reserved.
//

#import "HTHomeViewCell.h"


@interface HTHomeViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *contentImage;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *contentName;




@end

@implementation HTHomeViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.userInteractionEnabled=YES;
}

+(instancetype)homeViewCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HTHomeViewCell" owner:nil options:nil] lastObject];


}

-(void)setModel:(HTHomeViewCellModel *)model
{
    _model=model;
    
    self.contentImage.image=[UIImage imageNamed:model.contentImageName];
    self.iconImage.image=[UIImage imageNamed:model.iconImageName];
    self.userName.text=model.userName;
    self.contentName.text=model.contentName;
    

}

@end
