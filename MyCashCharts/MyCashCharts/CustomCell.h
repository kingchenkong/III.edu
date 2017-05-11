//
//  CustomCell.h
//  MyCashCharts
//
//  Created by 陳維漢 on 2016/9/2.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellTextLabel;

@end
