//
//  RankingAndChartsViewController.m
//  MyCashCharts
//
//  Created by 陳維漢 on 2016/9/2.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import "RankingAndChartsViewController.h"
#import <Crashlytics/Crashlytics.h>
@import Firebase;

@interface RankingAndChartsViewController () <DetailDataViewControllerDelegate>
{
    //資料初始化
    NSMutableArray *sectionName;
    
    // historyLog relation
    NSMutableArray *historyLog;
    NSMutableArray *historyLogPackage;
    NSMutableArray *historyLogCurrentMonth;         //  每月資料
    NSMutableArray *historyLogCurrentMonthDayCost;  //  分成每天的包裝
    NSMutableArray *historyLogOnlyDayGraduation;    //  只有天數的刻度
    
    NSMutableArray *historyforRankTop;              //
    NSMutableArray *rankTop30;                      //
    NSMutableArray *rankTop3;                       //
    
    //  rankCategory relation
    NSMutableArray *rankCategory;
    NSMutableArray *rankCategoryXLabel;             //  Ｘ軸 有的類別 -> 排序
    NSMutableArray *rankCategorypercentValue;       //  百分比數值
    NSMutableArray *rankCategoryEvery;              //  每個陣列的金額
    
}

//  Navi Bar Button
@property (weak, nonatomic) IBOutlet UINavigationItem *electCalenderNaviBarBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingNaviBarBtn;
//  Expand, Income
@property (weak, nonatomic) IBOutlet UIButton *expandBtn;
@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;

//  TableView
@property (weak, nonatomic) IBOutlet UITableView *rankTableView;


@end

@implementation RankingAndChartsViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        //  Fabric
        //  Crash test
        //        NSArray *arrayForCrashTest = [NSArray array];
        //        [arrayForCrashTest objectAtIndex:0];
        //  End
        
        //  資料初始化
        //  section text initial
        sectionName = [[NSMutableArray alloc] initWithObjects:@"歷史紀錄", @"TOP 3", @"類別排行", nil];
        
        historyLog = [NSMutableArray array];
        rankTop30 = [NSMutableArray array];
        rankCategory = [NSMutableArray array];
        
        //  歷史紀錄, loadCoreData -SortKey: @"updateTime" -YES
//        historyLog = [self loadCoreDataWithSortDescriptorKey:@"updateTime" withReceiveArray:historyLog ascendingFromLow:YES];
        historyLog = [self loadCoreDataWithSortDescriptorKey:@"strDate" withReceiveArray:historyLog ascendingFromLow:YES];
        
        //  Top 30, loadCoreData SortKey: @"cost"
        rankTop30 = [self loadCoreDataWithSortDescriptorKey:@"cost" withReceiveArray:rankTop30 ascendingFromLow:NO];
        
        if ([rankTop30 count] >= 3) {
            rankTop3 = [[NSMutableArray alloc] initWithObjects:rankTop30[0], rankTop30[1], rankTop30[2], nil];
            
            DetailData *logData;
            for (int i = 0; i < 3; i += 1) {
                logData = rankTop3[i];
                NSLog(@"%@ %@", logData.categoryName, logData.cost);
            }
            
            //  Add Arrays in "Display Array"
            _sectionItem = [[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@"假的", nil], rankTop3, [[NSMutableArray alloc] initWithObjects:@"假的", nil], nil];
        } else {
            
            //  Add Arrays in "Display Array"
            _sectionItem = [[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@"假的", nil], rankTop30, [[NSMutableArray alloc] initWithObjects:@"假的", nil], nil];
        }
        
        //  類別排行, loadCoreData SortKey: @""
        
        if (historyLog != nil) {
            [self sethistoryLogRelationArray];
        }
        
        //  update NSNotification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishUpdate:) name:@"DetailDataUpdated" object:nil];
        
    }
    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rankTableView.dataSource = self;
    _rankTableView.delegate = self;
    
    //    NSDate *date = [NSDate date];
    //    display current date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    self.navigationController.title = [NSString stringWithFormat:@"%@",currentDate];
    self.navigationItem.title = [NSString stringWithFormat:@"%@",currentDate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -IBAction
- (IBAction)selectCalenderNaviBarBtnPressed:(id)sender {
    
    //  Fabric
    // TODO: Track the user action that is important for you.
    [Answers logContentViewWithName:@"selectCalenderNaviBarBtnPressedInRanking" contentType:@"nil" contentId:@"RankingAndChartsVC" customAttributes:nil];
    //  FireBase
    [FIRAnalytics logEventWithName:@"selectCalenderNaviBarBtnPressedInRanking" parameters:@{}];
    
    
    
    
}

- (IBAction)settingNaviBarBtnPressed:(id)sender {
    
    //  Fabric
    // TODO: Track the user action that is important for you.
    [Answers logContentViewWithName:@"settingNaviBarBtnPressedInRanking" contentType:@"nil" contentId:@"RankingAndChartsVC" customAttributes:nil];
    //  FireBase
    [FIRAnalytics logEventWithName:@"settingNaviBarBtnPressed" parameters:@{}];
    
}

//  -IBAction to Expand, Income
- (IBAction)expandBtnPressed:(id)sender {
    
    //  Fabric
    // TODO: Track the user action that is important for you.
    [Answers logContentViewWithName:@"expandBtnPressedInRanking" contentType:@"nil" contentId:@"RankingAndChartsVC" customAttributes:nil];
    //  FireBase
    [FIRAnalytics logEventWithName:@"expandBtnPressed" parameters:@{}];
    
    
}

- (IBAction)incomeBtnPressed:(id)sender {
    
    //  Fabric
    // TODO: Track the user action that is important for you.
    [Answers logContentViewWithName:@"incomeBtnPressedInRanking" contentType:@"nil" contentId:@"RankingAndChartsVC" customAttributes:nil];
    //  FireBase
    [FIRAnalytics logEventWithName:@"incomeBtnPressed" parameters:@{}];
    
    //  Fabric
    // TODO: Track the user action that is important for you.
    //    [Answers logContentViewWithName:@"incomeBtnPressedInRanking" contentType:@"Video" contentId:@"RankingAndChartsVC" customAttributes:@{@"Favorites Count":@20, @"Screen Orientation":@"Landscape"}];
    
    
    
}

#pragma mark -UITableViewDataSource Section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_sectionItem count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [sectionName objectAtIndex:section];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    UILabel *myLabel = [[UILabel alloc] init];
//    myLabel.frame = CGRectMake(20, 8, 320, 50);
//    myLabel.font = [UIFont systemFontOfSize:30];
//    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
//
//    UIView *headerView = [[UIView alloc] init];
//    [headerView addSubview:myLabel];
//
//    return headerView;
//}

#pragma mark -UITableViewDataSource Cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //
    //    if (section == 0) {
    //        return 1;
    //    } else if (section == 1) {
    //        NSArray *temp = [_sectionItem objectAtIndex:section];
    //        return temp.count;
    //    } else if (section == 2) {
    //        return 1;
    //    }
    //    return 1;
    //
    NSArray *temp = [_sectionItem objectAtIndex:section];
    return temp.count;
    
    return [[_sectionItem objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 200.0;
    } else if (indexPath.section == 1) {
        return 50.0;
    }else if (indexPath.section == 2) {
        return 200.0;
    } else {
        return 0.0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRanking" forIndexPath:indexPath];
    DetailData *data = [[_sectionItem objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (data != nil ) {
        
        if (indexPath.section == 0) {
            //  Custom Line Chart Cell
            CustomLineChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellLine" forIndexPath:indexPath];
            //            CustomLineChartCell *cell = [[CustomLineChartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellLine"];
            
            cell.cellBackgroundView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //  removeFromSuperview
            [self.lineChart removeFromSuperview];
            
            //  設定cell點下去沒有顏色
            self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, 320, 179.5)];
            //            self.lineChart.translatesAutoresizingMaskIntoConstraints  = NO;
            self.lineChart.yLabelFormat = @"%1.1f";
            self.lineChart.backgroundColor = [UIColor clearColor];
            //            [self.lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5",@"SEP 6",@"SEP 7"]];
            [self.lineChart setXLabels:historyLogOnlyDayGraduation];
            
            self.lineChart.showCoordinateAxis = NO;
            
            // added an examle to show how yGridLines can be enabled
            // the color is set to clearColor so that the demo remains the same
            self.lineChart.yGridLinesColor = [UIColor clearColor];
            self.lineChart.showYGridLines = NO;
            
            //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
            //Only if you needed
            
            
            //  取得 本月目前支出 最大值
            int maximumValue = [[historyLogCurrentMonthDayCost valueForKeyPath: @"@max.self"] intValue];
            NSLog(@" MaximumValue = %d", maximumValue);
            CGFloat maxCGF = (CGFloat)maximumValue;
            NSLog(@"%.1f",maxCGF);
            
            self.lineChart.yFixedValueMax = maxCGF;
            self.lineChart.yFixedValueMin = 0.0;
            
            //  本月支出最大值 ~ 0 分 6個 刻度
            NSMutableArray *yLabelGraduation = [NSMutableArray array];
            for (int i = 0; i < 7; i += 1) {
                if (i == 0) {
                    [yLabelGraduation addObject:[NSString stringWithFormat:@"%.1f",0.0]];
                } else {
                    [yLabelGraduation addObject:[NSString stringWithFormat:@"%.1f", maxCGF/6*i]];
                }
                NSLog(@"%@", yLabelGraduation);
            }
            
            //            [self.lineChart setYLabels:@[
            //                                         @"0",
            //                                         @"50",
            //                                         @"100",
            //                                         @"150",
            //                                         @"200",
            //                                         @"250",
            //                                         @"300",
            //                                         ]
            //             ];
            [self.lineChart setYLabels:yLabelGraduation];
            
            // Line Chart #1
            //            NSArray * data01Array = @[@60.1, @160.1, @126.4, @0.0, @186.2, @127.2, @176.2];
            NSArray * data01Array = historyLogCurrentMonthDayCost;
            
            PNLineChartData *data01 = [PNLineChartData new];
            data01.dataTitle = @"Alpha";
            data01.color = PNFreshGreen;
            data01.alpha = 0.3f;
            data01.itemCount = data01Array.count;
            data01.inflexionPointColor = PNRed;
            data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
            data01.getData = ^(NSUInteger index) {
                CGFloat yValue = [data01Array[index] floatValue];
                return [PNLineChartDataItem dataItemWithY:yValue];
            };
            
            // Line Chart #2
            //            NSArray * data02Array = @[@0.0, @180.1, @26.4, @202.2, @126.2, @167.2, @276.2];
            //            PNLineChartData *data02 = [PNLineChartData new];
            //            data02.dataTitle = @"Beta";
            //            data02.color = PNTwitterColor;
            //            data02.alpha = 0.5f;
            //            data02.itemCount = data02Array.count;
            //            data02.inflexionPointStyle = PNLineChartPointStyleCircle;
            //            data02.getData = ^(NSUInteger index) {
            //                CGFloat yValue = [data02Array[index] floatValue];
            //                return [PNLineChartDataItem dataItemWithY:yValue];
            //            };
            //
            //            self.lineChart.chartData = @[data01, data02];
            self.lineChart.chartData = @[data01];
            [self.lineChart strokeChart];
            self.lineChart.delegate = self;
            
            [cell.cellBackgroundView addSubview:self.lineChart];
            //            NSArray *hs = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[chart]|" options:nil metrics:nil views:@{@"chart":self.lineChart}];
            //
            //            NSArray *vs = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[chart]|" options:nil metrics:nil views:@{@"chart":self.lineChart}];
            //            [NSLayoutConstraint activateConstraints:vs];
            //            [NSLayoutConstraint activateConstraints:hs];
            //
            //            self.lineChart.legendStyle = PNLegendItemStyleStacked;
            //            self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
            //            self.lineChart.legendFontColor = [UIColor redColor];
            //
            //            UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
            //            [legend setFrame:CGRectMake(30, 340, legend.frame.size.width, legend.frame.size.width)];
            //
            //            //  addSubview
            //            [self.view addSubview:legend];
            
            return cell;
        } else if (indexPath.section == 1) {
            //            DetailData *data = [[_sectionItem objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            
            //  Custom Cell
            CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRanking" forIndexPath:indexPath];
            
            //  textlabel.text & imageName
            NSString *imageName = [NSString stringWithFormat:@"0-%@", data.categoryName];
            NSLog(@"imageName: %@",imageName);
            
            //  Background Color
            NSString *categoryColor = data.categoryColor;
            //  NSLog(@"categoryColor: %@", categoryColor);
            cell.cellBackgroundView.backgroundColor = [UIColor colorWithHexString:categoryColor];
            cell.cellImageView.image = [UIImage imageNamed:imageName];
            
            CGSize itemSize = [cell.cellBackgroundView bounds].size;
            CGFloat itemWidth = itemSize.width;
            
            cell.cellBackgroundView.layer.cornerRadius = itemWidth/5;
            //  NSLog(@"%.1f",itemWidth/5);
            cell.cellBackgroundView.layer.masksToBounds = YES;
            cell.cellTextLabel.text = [NSString stringWithFormat:@"%@ : NT$ %@", data.categoryName, data.cost];
            
            [cell.cellTextLabel sizeToFit];
            
            return cell;
        } else if (indexPath.section == 2) {
            //  Custom Line Chart Cell
            CustomBarChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellBar" forIndexPath:indexPath];
            
            cell.cellBackgroundView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //  removeFromSuperview
            [self.barChart removeFromSuperview];
            
            static NSNumberFormatter *barChartFormatter;
            if (!barChartFormatter){
                barChartFormatter = [[NSNumberFormatter alloc] init];
                barChartFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
                barChartFormatter.allowsFloats = NO;
                barChartFormatter.maximumFractionDigits = 0;
            }
            
            self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0, 320, 179.5)];
            //        self.barChart.showLabel = NO;
            self.barChart.backgroundColor = [UIColor clearColor];
            self.barChart.yLabelFormatter = ^(CGFloat yValue){
                return [barChartFormatter stringFromNumber:[NSNumber numberWithFloat:yValue]];
            };
            
            self.barChart.yChartLabelWidth = 30.0;
            self.barChart.chartMarginLeft = 30.0;
            self.barChart.chartMarginRight = 10.0;
            self.barChart.chartMarginTop = 5.0;
            self.barChart.chartMarginBottom = 10.0;
            
            self.barChart.labelMarginTop = 5.0;
            self.barChart.showChartBorder = YES;
            //            [self.barChart setXLabels:@[@"2",@"3",@"4",@"5",@"2",@"3",@"4",@"5"]];
            [self.barChart setXLabels:rankCategoryXLabel];
            
            //       self.barChart.yLabels = @[@-10,@0,@10];
            //        [self.barChart setYValues:@[@10000.0,@30000.0,@10000.0,@100000.0,@500000.0,@1000000.0,@1150000.0,@2150000.0]];
            //            [self.barChart setYValues:@[@10.82,@1.88,@6.96,@33.93,@10.82,@1.88,@6.96,@33.93]];
            [self.barChart setYValues:rankCategorypercentValue];
            
            [self.barChart setStrokeColors:@[PNGreen,PNGreen,PNRed,PNGreen,PNGreen,PNGreen,PNRed,PNGreen]];
            self.barChart.isGradientShow = NO;
            self.barChart.isShowNumbers = NO;
            
            [self.barChart strokeChart];
            
            self.barChart.delegate = self;
            
            //            [self.view addSubview:self.barChart];
            [cell.cellBackgroundView addSubview:self.barChart];
            
            return cell;
        } else {
            //  else cell
            CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRanking" forIndexPath:indexPath];
            return cell;
        }
        
        
        
        //  for Default Data
        //    cell.cellTextLabel.text = [[_sectionItem objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        //    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    
    //            switch (indexPath.section) {
    //                case 0:
    //                    //  歷史紀錄
    //                    cell.cellTextLabel.text = [NSString stringWithFormat:@"%@ : NT$ %@ : %@", data.categoryName, data.cost, data.updateTime];
    //                    break;
    //                case 1:
    //                    //  Top 30
    //                    cell.cellTextLabel.text = [NSString stringWithFormat:@"%@ : NT$ %@", data.categoryName, data.cost];
    //                    break;
    //                case 2:
    //                    //  類別排行
    //
    //                    break;
    //
    //                default:
    //                    break;
    //            }
    
    
    //    //  Example
    //    static NSString *cellIdentifier = @"cell";
    //    if (indexPath.section == 0) {
    //        // cell for section one
    //        HeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //        if(!headerCell) {
    //            [tableView registerNib:[UINib nibWithNibName:@"HeaderCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    //            headerCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //        }
    //        headerCell.labelName.text = @"First Section";
    //        return headerCell;
    //    }
    //    else {
    //        // Cell for another section
    //        DetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //        if (!detailSection) {
    //            [tableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    //            detailCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //        }
    //        detailCell.textLabel.text = @"Another Section Row";
    //        return detailCell;
    //    }
    
    
    
    //  data = nil
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRanking" forIndexPath:indexPath];
    return cell;
    
}

////      protocol的做法
//-(void)didFinishUpdateDeatilData:(DetailData *)detailData{
//    //  find Array id
//    NSUInteger index = [historyLog indexOfObject:detailData];
//    //  build NSIndexPath
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    //  reload this data
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//
////    [self saveToCoreData];
//}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSLog(@"%ld 筆被按到",(long)indexPath.row);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  //  使被選取放開後的"灰底"-消失
}

#pragma mark -Core Data
-(NSMutableArray *)loadCoreDataWithSortDescriptorKey:(NSString *)sortDescriptorKey withReceiveArray:(NSMutableArray *)receiveArray ascendingFromLow:(BOOL)ascending {
    
    //query
    NSManagedObjectContext *context = [CoreDataHelper sharedInstance].managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"DetailData"];
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:sortDescriptorKey ascending:ascending];
    //  Sort 新增的放前面
    NSError *error;
    [fetchRequest setSortDescriptors:@[timeSort]];
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"ERROR !! %@",error);
    } else {
        //  Core Data Load出來是 一個一個的物件,  個別資料的細項 要用 object.property的方式讀取
        //  編列成一個Array 方便讀取
        receiveArray = [NSMutableArray arrayWithArray:results];
    }
    return receiveArray;
}

//  通知的做法
-(void)finishUpdate:(NSNotification *)notification{
    
    //  歷史紀錄 -NSMutableArray historyLog
    historyLog = [self loadCoreDataWithSortDescriptorKey:@"updateTime" withReceiveArray:historyLog ascendingFromLow:YES];
    [self sethistoryLogRelationArray];
    
    //  rank Top 30
    rankTop30 = [self loadCoreDataWithSortDescriptorKey:@"cost" withReceiveArray:rankTop30 ascendingFromLow:NO];
    
    if ([rankTop30 count] >= 3) {
        rankTop3 = [[NSMutableArray alloc] initWithObjects:rankTop30[0], rankTop30[1], rankTop30[2], nil];
        
        DetailData *logData;
        for (int i = 0; i < 3; i += 1) {
            logData = rankTop3[i];
            NSLog(@"%@ %@", logData.categoryName, logData.cost);
        }
        _sectionItem = [[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@"假的", nil], rankTop3, [[NSMutableArray alloc] initWithObjects:@"假的", nil], nil];
    } else {
        _sectionItem = [[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@"假的", nil], rankTop30, [[NSMutableArray alloc] initWithObjects:@"假的", nil], nil];
    }
    
    [self.rankTableView reloadData];
}

#pragma mark -Navigation PrepareForSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //  sugue toExpandDetail
    if ([segue.identifier isEqualToString:@"toExpandDetail"]) {
        DetailDataViewController *detailDataVC = segue.destinationViewController;
        detailDataVC.isCategoryExpand = YES;
        detailDataVC.dataWayString = [NSString stringWithFormat:@"isNewWay"];     //  RankingVC to DetilDataVC
        
        // init ExpressObject
        ExpressObject *expressObj = [[ExpressObject alloc] init];
        
        //        expressObj.categoryName = [NSString stringWithFormat:@"is A New Expand"];
        detailDataVC.currentExpressObject = expressObj;
        
    }
    
    if ([segue.identifier isEqualToString:@"toIncomeDetail"]) {
        DetailDataViewController *detailDataVC = segue.destinationViewController;
        detailDataVC.isCategoryExpand = NO;
        detailDataVC.dataWayString = [NSString stringWithFormat:@"isNewWay"];     //  RankingVC to DetilDataVC
        
        // init ExpressObject
        ExpressObject *expressObj = [[ExpressObject alloc] init];
        
        //        expressObj.categoryName = [NSString stringWithFormat:@"is A New Income"];
        detailDataVC.currentExpressObject = expressObj;
        
        
    }
    if ([segue.identifier isEqualToString:@"toHistoryLog"]) {
        HistoryLogTableViewController *historyLogTVC = segue.destinationViewController;
        //      取得使用者點選位置
        historyLogTVC.historyLogArray = historyLog;
        historyLogTVC.historyLogCurrentMonthArray = historyLogCurrentMonth;
        
        
    }
    
    if ([segue.identifier isEqualToString:@"toEditDetail"]) {
        
        DetailDataViewController *detailDataVC = segue.destinationViewController;
        //      取得使用者點選位置
        NSIndexPath * indexPath = self.rankTableView.indexPathForSelectedRow;
        DetailData *data = [[_sectionItem objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        
        detailDataVC.currentDetailData = data;
        //  DetailData Property
        detailDataVC.categoryName = data.categoryName;          //  類別名
        detailDataVC.categoryColor = data.categoryColor;        //  顏色字串 Hex
        detailDataVC.detailCategoryName = data.detailCategoryName;  //  細項名
        detailDataVC.dataName = data.dataName;                  //  自訂項目名稱
        detailDataVC.location = data.location;                  //  消費地點 or收入地點
        detailDataVC.manageProject = data.manageProject;        //  管理本筆資料的 專案
        //  NSNumber
        detailDataVC.cost = data.cost;                          //  本次消費
        detailDataVC.isExpandItem = data.isExpandItem;          //  YES : 支出, NO : 收入
        
        if ([data.isExpandItem isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            detailDataVC.isCategoryExpand = YES;
        } else {
            detailDataVC.isCategoryExpand = NO;
        }
        
        //  NSDate
        detailDataVC.updateTime = data.updateTime;              //  紀錄 or編輯時間
        //  Data come from
        detailDataVC.dataWayString = [NSString stringWithFormat:@"isEditWay"];     //  RankingVC to DetilDataVC
        detailDataVC.categoryImageFileName = data.categoryImageFileName;            //  categoryImageFileName
        detailDataVC.detailCategoryImageFileName = data.detailCategoryImageFileName;//  detailCategoryImageFileName
        
        //
        ExpressObject *expressObj = [[ExpressObject alloc] init];
        
        //  Follow CoreData
        
        expressObj.categoryName = data.categoryName;
        expressObj.detailCategoryName = data.detailCategoryName;
        expressObj.dataName = data.dataName;
        expressObj.location = data.location;
        expressObj.manageProject = data.manageProject;
        expressObj.cost = data.cost;
        expressObj.updateTime = data.updateTime;
        expressObj.isExpandItem = data.isExpandItem;
        expressObj.categoryColor = data.categoryColor;
        expressObj.categoryImageFileName = data.categoryImageFileName;
        expressObj.detailCategoryImageFileName = data.detailCategoryImageFileName;
        expressObj.categoryArrayIndex = data.categoryArrayIndex;
        
        
        detailDataVC.currentExpressObject = expressObj;
        //        detailDataVC.currentExpressObject.categoryArrayIndex = data.categoryArrayIndex;
        //        detailDataVC.currentExpressObject.categoryImageFileName = data.categoryImageFileName;
        
        
    }
    
}

#pragma mark -Methods for clean up Code

-(void) sethistoryLogRelationArray {
    
    historyLogCurrentMonth = [NSMutableArray array];
    historyLogOnlyDayGraduation = [NSMutableArray array];
    historyLogCurrentMonthDayCost = [NSMutableArray array];
    
    rankCategoryXLabel = [NSMutableArray array];
    rankCategorypercentValue = [NSMutableArray array];
    
    // 本月 -NSMutableArray historyLogCurrentMonth
    NSDate *date = [NSDate date];   //  just display current date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM"];
    NSString *currentMonth = [formatter stringFromDate:date];
    NSLog(@"currentMonth: %@", currentMonth);
    
    DetailData *logData;
    for (int i = 0 ; i< [historyLog count]; i += 1) {
        logData = [historyLog objectAtIndex:i];
        
        if ([logData.strDate containsString:currentMonth]) {
            NSLog(@".strDate No.%d :%@ contains %@!!", i, logData.strDate, currentMonth);
            [historyLogCurrentMonth addObject:logData];
            // contains!!
        } else {
            NSLog(@".strDate No.%d does not contains %@", i, currentMonth);
        }
        
        if (i == ([historyLog count]-1)) {
            NSLog(@"now contains %d item",i + 1);
            //  index 3時,應有 4 筆資料 contains
        }
    }
    
    //  check historyLogCurrentMonth)
    for (int i = 0; i< [historyLogCurrentMonth count]; i += 1) {
        logData = [historyLogCurrentMonth objectAtIndex:i];
        NSLog(@"index:%d %@", i, logData.dataName);
    }
    
    //  每日消費, 本月已過天數刻度
    // 天數的刻度
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger currentday = [components day];
    
    NSDateFormatter *formatterDay = [[NSDateFormatter alloc] init];
    [formatterDay setDateFormat:@"dd"];
    NSString *currentDay = [formatterDay stringFromDate:date];
    NSLog(@"currentDay: %@", currentDay);
    
    for (NSInteger interger = 1; interger <= currentday; interger +=1) {
        if (interger < 10) {
            [historyLogOnlyDayGraduation addObject:[NSString stringWithFormat:@"0%ld",interger]];
        } else {
            [historyLogOnlyDayGraduation addObject:[NSString stringWithFormat:@"%ld",interger]];
        }
    }
    //  -NSMutableArray historyLogCurrentMonthDayCost 把historyLog分成每天的包裝, 裡面是 -NSNumber
    //        NSString *currentDayString;
    NSRange rangeDay = NSMakeRange (8, 2);
    
    for (int i = 0; i < [historyLogOnlyDayGraduation count]; i += 1) {
        [historyLogCurrentMonthDayCost addObject:[NSNumber numberWithInt:0]];
    }
    
    //
    //     cost expand 加算地區
    //
    NSNumber *a;
    NSNumber *b;
    NSNumber *c;
    NSString *strDateOnlyDay;
    NSInteger indexDay;
    for (int j = 0; j< [historyLogCurrentMonth count] ; j += 1) {
        logData = [historyLogCurrentMonth objectAtIndex:j];
        strDateOnlyDay = [NSString stringWithFormat:@"%@", [logData.strDate substringWithRange:rangeDay]];
        indexDay = [strDateOnlyDay integerValue] - 1;
        //            NSLog(@"j=%d, %@, %ld", j, strDateOnlyDay, indexDay);
        a = [historyLogCurrentMonthDayCost objectAtIndex:indexDay];
        b = logData.cost;
       

        if ([logData.isExpandItem isEqual:@(1)]) {
            c = [NSNumber numberWithInt:[a intValue] + [b intValue]];
        historyLogCurrentMonthDayCost [indexDay] = [NSNumber numberWithInt:[a intValue] + [b intValue]];

        } else {
            c = [NSNumber numberWithInt:[a intValue] - [b intValue]];
        historyLogCurrentMonthDayCost [indexDay] = [NSNumber numberWithInt:[a intValue] - [b intValue]];

        }
        
//        income not yet build!!! (declare~~~
//        --    historyLogCurrentMonthDayIncome

        
//        c = [NSNumber numberWithInt:[a intValue] + [b intValue]];        
//        historyLogCurrentMonthDayCost [indexDay] = [NSNumber numberWithInt:[a intValue] + [b intValue]];
        
    }
    for (int i = 0; i < [historyLogCurrentMonthDayCost count]; i += 1) {
        NSLog(@"%d day cost: %d", i, [[historyLogCurrentMonthDayCost objectAtIndex:i] intValue]);
        
    }
    //  哪些群組
    if (historyLogCurrentMonth != nil) {
        if (rankCategoryXLabel != nil) {    //  rankCategoryXLabel [0] 存在
            for (int i = 0; i < [historyLogCurrentMonth count]; i += 1) {
                logData = [historyLogCurrentMonth objectAtIndex:i];
                rankCategoryXLabel [i] = [NSString stringWithFormat:@"%@", logData.categoryName];
            }
            NSString *ran;
            NSString *ranCXLi;
            for (int j = 0; j < [rankCategoryXLabel count]; j += 1) {
                ran = [NSString stringWithFormat:@"%@", rankCategoryXLabel[j]];
                for (int i = j + 1; i < [rankCategoryXLabel count]; i += 1) {
                    ranCXLi = [NSString stringWithFormat:@"%@", rankCategoryXLabel[i]];
                    if ([ran isEqualToString:[NSString stringWithFormat:@"%@", ranCXLi]]) {
                        [rankCategoryXLabel removeObjectAtIndex:i];
                        i -= 1;
                    }
                }
            }
        }
    }
    NSLog(@"################is Check!!!!###################");
    for (int i = 0; i < [rankCategoryXLabel count]; i += 1) {
        NSLog(@"%@", rankCategoryXLabel [i]);
    }
    //  每個群組消費
    //  Array - 總量
    //  Array - 各類別佔多少
    //  rankCategoryXLabel 第 i 個, 有 j 個 Array 要去檢查 並加入
    rankCategoryEvery = [NSMutableArray array];
    NSInteger everyCategoryCost;
    NSInteger currentMonthCost;
    for (int i = 0 ; i < [rankCategoryXLabel count]; i += 1) {
        [rankCategoryEvery addObject:[NSString stringWithFormat:@"0"]];
    }
    
    for (int i = 0; i < [rankCategoryXLabel count]; i += 1) {
        for (int j = 0; j < [historyLogCurrentMonth count]; j += 1) {
            logData = [historyLogCurrentMonth objectAtIndex:j];
            NSString *categoryName = [NSString stringWithFormat:@"%@", logData.categoryName];
            if ([categoryName isEqualToString:[NSString stringWithFormat:@"%@", rankCategoryXLabel[i]]]) {
                everyCategoryCost = [rankCategoryEvery[i] integerValue];
                currentMonthCost = [logData.cost integerValue];
                everyCategoryCost += currentMonthCost;
                rankCategoryEvery [i] = [NSString stringWithFormat:@"%ld", everyCategoryCost];
            }
        }
    }
    for (int i = 0; i < [rankCategoryEvery count]; i += 1) {
        NSLog(@"%@", rankCategoryEvery[i]);
    }
    //  排序 大小
    NSInteger intBigest;
    NSInteger intMaybeBigger;
    NSString *categoryBigest;
    NSString *categoryMaybeBigger;
    
    for (int j = 0; j < [rankCategoryEvery count]; j += 1) {
        for (int i = j + 1; i < [rankCategoryEvery count]; i += 1) {
            intBigest = [rankCategoryEvery [j] integerValue];
            intMaybeBigger = [rankCategoryEvery [i] integerValue];
            categoryBigest = [NSString stringWithFormat:@"%@", rankCategoryXLabel [j]];
            categoryMaybeBigger = [NSString stringWithFormat:@"%@", rankCategoryXLabel [i]];
            
            if (intMaybeBigger > intBigest) {
                NSLog(@"bigger: %ld > bigest %ld ", intMaybeBigger, intBigest);
                rankCategoryEvery [j] = [NSString stringWithFormat:@"%ld", intMaybeBigger];
                rankCategoryEvery [i] = [NSString stringWithFormat:@"%ld", intBigest];
                rankCategoryXLabel [j] = categoryMaybeBigger;
                rankCategoryXLabel [i] = categoryBigest;
            }
        }
    }
    
    //
    CGFloat percentValue = 0.0;
    NSInteger hundredPercentValue = 0;
    rankCategorypercentValue = [NSMutableArray arrayWithArray:rankCategoryEvery];
    
    for (int i = 0; i < [rankCategoryEvery count]; i += 1) {
        hundredPercentValue += [rankCategoryEvery [i] integerValue];
        NSLog(@"%@", rankCategoryEvery[i]);
        NSLog(@"%@", rankCategoryXLabel[i]);
    }
    NSLog(@"hundredPercentValue: %ld",hundredPercentValue);
    
    if (hundredPercentValue != 0) {
        for (int i = 0; i < [rankCategoryEvery count]; i += 1) {
            
            NSInteger molecular = [rankCategoryEvery[i] integerValue];
            percentValue = (CGFloat)molecular * 100.0 / (CGFloat)hundredPercentValue;
            NSLog(@"%.1f",percentValue);
            //            [rankCategorypercentValue[i] addObject:[NSString stringWithFormat:@"%.1f", percentValue]];
            rankCategorypercentValue[i] = [NSString stringWithFormat:@"%.1f%%", percentValue];
            
            
        }
    }
    
    for (int i = 0; i < [rankCategoryEvery count]; i += 1) {
        NSLog(@"%@", rankCategorypercentValue[i]);
        NSLog(@"%@", rankCategoryXLabel[i]);
    }
    
}


@end
