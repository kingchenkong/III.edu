//
//  HistoryLogTableViewController.m
//  MyCashCharts
//
//  Created by 陳維漢 on 2016/9/8.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import "HistoryLogTableViewController.h"

@interface HistoryLogTableViewController (){
    DetailData *detailData;
}

@end

@implementation HistoryLogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_historyLogCurrentMonthArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    detailData = [_historyLogCurrentMonthArray objectAtIndex:indexPath.row];
    
    //  CustomHistoryLogCell Cell
    CustomHistoryLogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellHistory" forIndexPath:indexPath];
    
    //  textlabel.text & imageName
    NSString *imageName = [NSString stringWithFormat:@"0-%@", detailData.categoryName];
    NSLog(@"imageName: %@",imageName);
    
    //  Background Color
    NSString *categoryColor = detailData.categoryColor;
    //  NSLog(@"categoryColor: %@", categoryColor);
    cell.cellBackgroundView.backgroundColor = [UIColor colorWithHexString:categoryColor];
    cell.cellImageView.image = [UIImage imageNamed:imageName];
    
    CGSize itemSize = [cell.cellBackgroundView bounds].size;
    CGFloat itemWidth = itemSize.width;
    
    cell.cellBackgroundView.layer.cornerRadius = itemWidth/5;
    //  NSLog(@"%.1f",itemWidth/5);
    cell.cellBackgroundView.layer.masksToBounds = YES;
    cell.cellTextLabel.text = [NSString stringWithFormat:@"%@ : NT$ %@", detailData.categoryName, detailData.cost];
    
    [cell.cellTextLabel sizeToFit];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0;
}


/* #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
