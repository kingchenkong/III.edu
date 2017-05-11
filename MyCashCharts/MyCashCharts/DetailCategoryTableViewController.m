//
//  DetailCategoryTableViewController.m
//  MyCashCharts
//
//  Created by 陳維漢 on 2016/9/2.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import "DetailCategoryTableViewController.h"

@interface DetailCategoryTableViewController ()
{
    
}

@end

@implementation DetailCategoryTableViewController

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
    
    NSMutableDictionary *categoryData = [cashPropertyList objectForKey:@"categoryData"];
    
    //  show the list Expand or Income
    if ([_currentExpressObject.isExpandItem isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        NSMutableArray *detailCategory_Array = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"detailCategory_Expand"]];
        
        _cellDetailCategoryItem = [detailCategory_Array objectAtIndex: [_currentExpressObject.categoryArrayIndex integerValue]];
        
    } else {
        NSMutableArray *detailCategory_Array = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"detailCategory_Income"]];
        _cellDetailCategoryItem = [detailCategory_Array objectAtIndex: [_currentExpressObject.categoryArrayIndex integerValue]];
    }
    //    NSLog(@"_showDetailExpand: %d",_showDetailExpand);
    
    //  post
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"DetailDataUpdated" object:nil userInfo:@{@"detailData":detailData}];
    
    //  receive
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishUpdate:) name:@"DetailDataUpdated" object:nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellDetailCategoryItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellDetailCategory" forIndexPath:indexPath];
    
    //  original
    //    cell.textLabel.text = _cellDetailCategoryItem [indexPath.row];
    
    //  Custom Cell
    //  textlabel.text & imageName
    NSString *imageName = [NSString stringWithFormat:@"%ld-%@", indexPath.row+1, _cellDetailCategoryItem[indexPath.row]];
    //        NSLog(@"%@",imageName);
    
    //  Background Color
    NSString *categoryColor = _currentExpressObject.categoryColor;
    cell.imageView.backgroundColor = [UIColor clearColor];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(3, 3, 44, 44)];
    backgroundView.backgroundColor = [UIColor colorWithHexString:categoryColor];
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
    
    UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 +itemWidth, 3, 100, 44)];
    cellLabel.text = _cellDetailCategoryItem [indexPath.row];
    
    [cell.contentView addSubview:cellLabel];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0;
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    DetailDataViewController *detailDataVC = segue.destinationViewController;
//    detailDataVC.categoryName = [NSString stringWithFormat:@"%@",_currentCategoryName];
//    
//    //      取得使用者點選位置
//    NSIndexPath * indexPath = self.tableView.indexPathForSelectedRow;
//    detailDataVC.detailCategoryName = [_cellDetailCategoryItem objectAtIndex:indexPath.row];
//    
//    //      將該 位置(row) 傳給下一個畫面
//    detailDataVC.currentCategoryIndex = _currentCategory;
//    detailDataVC.currentDetailCategoryIndex = indexPath.row;
//    detailDataVC.isCategoryExpand = _isCategoryExpand;
//    detailDataVC.isExpandItem = [NSNumber numberWithBool:_isCategoryExpand];
//    
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
//    self.selectedData.detailCategoryName = @""
    
    // test indexPath.row
    NSLog(@"%ld", indexPath.row);
    
    _currentExpressObject.detailCategoryImageFileName = [NSString stringWithFormat:@"%ld-%@", indexPath.row+1, _cellDetailCategoryItem[indexPath.row]];
    _currentExpressObject.detailCategoryName = _cellDetailCategoryItem[indexPath.row] ;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateCategory" object:nil userInfo:nil];
    

    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];

}



@end
