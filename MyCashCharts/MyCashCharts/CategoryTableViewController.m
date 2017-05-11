//
//  CategoryTableViewController.m
//  MyCashCharts
//
//  Created by 陳維漢 on 2016/9/2.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import "CategoryTableViewController.h"

@interface CategoryTableViewController ()
{
    NSMutableArray *categoryColor_Array;

}

@end

@implementation CategoryTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  Set AppDelegate All Path Varables
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate getPathWithAppDelegateProperty];
    
    // Read all plist var at CashPropertyList.plist
    NSMutableDictionary *cashPropertyList = [NSMutableDictionary dictionaryWithContentsOfFile:appDelegate.plistFilePath];
    
    // Write nowIsExpand = _showListExpand to NSUserDefault
    [cashPropertyList setValue:[NSNumber numberWithBool:_isCategoryExpand] forKey:@"nowIsExpand"];
    [cashPropertyList writeToFile:appDelegate.plistFilePath atomically:YES];
    
    
    
    //  show the list Expand or Income
    if (_isCategoryExpand) {
        // get Array categoryName
        NSMutableDictionary *categoryData = [cashPropertyList objectForKey:@"categoryData"];
        _cellCategoryItem = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"categoryName_Expand"]];
        // get Array Color
        categoryColor_Array = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"categoryColor_Expand"]];
        
    } else {
        // get Array categoryName
        NSMutableDictionary *categoryData = [cashPropertyList objectForKey:@"categoryData"];
        _cellCategoryItem = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"categoryName_Income"]];
        // get Array Color
        categoryColor_Array = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"categoryColor_Income"]];
        
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellCategoryItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellCategory" forIndexPath:indexPath];
    
    //  Custom Cell
    //  textlabel.text & imageName
    NSString *imageName = [NSString stringWithFormat:@"0-%@",  _cellCategoryItem[indexPath.row]];
    //    NSLog(@"%@",imageName);
    
    //  Background Color
    NSString *categoryColor = [categoryColor_Array objectAtIndex:indexPath.row];
    cell.imageView.backgroundColor = [UIColor clearColor];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(3, 3, 44, 44)];
    backgroundView.backgroundColor = [UIColor colorWithHexString:categoryColor];
    
    //  cellImageView
    UIImageView *cellImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    cellImageView.frame = CGRectMake(5, 5, 34, 34);
    
    CGSize itemSize = [backgroundView bounds].size;
    CGFloat itemWidth = itemSize.width;
    //    CGFloat itemHeight = itemSize.height; //   Unused
    
    backgroundView.layer.cornerRadius = itemWidth/5;
    //        NSLog(@"%.1f",itemWidth/5);
    cell.imageView.layer.masksToBounds = YES;
    
    [backgroundView addSubview:cellImageView];
    [cell.contentView addSubview:backgroundView];
    
    //  cellLabel
    UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 +itemWidth, 3, 100, 44)];
    cellLabel.text = _cellCategoryItem[indexPath.row];
    
    [cell.contentView addSubview:cellLabel];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"CategoryToDetailCategory"]) {
        //      DetailCategoryTableViewController
        DetailCategoryTableViewController *detailCategoryTableVC = segue.destinationViewController;
        //      取得使用者點選位置
        NSIndexPath * indexPath = self.tableView.indexPathForSelectedRow;
        //      將該 位置(row) 傳給下一個畫面
        
        //  ExpressObject -- newthing
        _currentExpressObject.categoryArrayIndex = [NSNumber numberWithInteger:indexPath.row];
        _currentExpressObject.categoryName = _cellCategoryItem[indexPath.row];
        _currentExpressObject.categoryImageFileName = [NSString stringWithFormat:@"0-%@",  _cellCategoryItem[indexPath.row]];
        _currentExpressObject.categoryColor = categoryColor_Array[indexPath.row];
        _currentExpressObject.isExpandItem = [NSNumber numberWithBool:_isCategoryExpand];
        
        detailCategoryTableVC.currentExpressObject = _currentExpressObject;
        
        //  old
        
        detailCategoryTableVC.currentCategory = indexPath.row;
//        detailCategoryTableVC.currentCategoryName = _cellCategoryItem[indexPath.row];
//        detailCategoryTableVC.currentCategoryColor = categoryColor_Array[indexPath.row];
//        if (_isCategoryExpand) {
//            detailCategoryTableVC.isCategoryExpand = YES;
//        } else {
//            detailCategoryTableVC.isCategoryExpand = NO;
//        }
        
        NSLog(@"test now");
        
        
    }
}


@end
