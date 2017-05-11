//
//  DetailDataViewController.m
//  MyCashCharts
//
//  Created by 陳維漢 on 2016/9/2.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import "DetailDataViewController.h"

@interface DetailDataViewController () <UITextFieldDelegate>
{
    UITapGestureRecognizer *tapRecognizer;
    UITextField * currentTextField;
    //    NSString *categoryColor;
    //    DetailData *detailData;
}

#pragma mark IBOutlet
//  icon, temporary use UIButton
@property (weak, nonatomic) IBOutlet UIButton *iconCategory;
@property (weak, nonatomic) IBOutlet UIButton *iconDetailCategory;
@property (weak, nonatomic) IBOutlet UIImageView *iconCategoryImageview;
@property (weak, nonatomic) IBOutlet UIImageView *iconDetailCategoryImageview;
@property (weak, nonatomic) IBOutlet UILabel *iconCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *iconDetailCategoryLabel;




//  Textfield
@property (weak, nonatomic) IBOutlet UITextField *costTextField;
@property (weak, nonatomic) IBOutlet UITextField *dataNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;

//  LabelBtn
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UIButton *managerProjectNameBtn;

@end

@implementation DetailDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  For Test
    //    NSLog(@"_currentExpressObject.categoryName: %@", _currentExpressObject.categoryName);
    //    _currentExpressObject.categoryName = @"";
    //    NSLog(@"_currentExpressObject.categoryName: %@", _currentExpressObject.categoryName);
    
    
    //  Set AppDelegate All Path Varables
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate getPathWithAppDelegateProperty];
    
    // Read all plist var at CashPropertyList.plist
    NSMutableDictionary *cashPropertyList = [NSMutableDictionary dictionaryWithContentsOfFile:appDelegate.plistFilePath];
    NSMutableDictionary *categoryData = [cashPropertyList objectForKey:@"categoryData"];
    
    //  不變的設定
    //  textField.delagete
    _costTextField.delegate = self;
    _dataNameTextField.delegate = self;
    _locationTextField.delegate = self;
    _dateTextField.delegate = self;
    
    //  becomeFirstResponder
    [_costTextField becomeFirstResponder];
    
    //  keyboardType
//    _costTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    
    
    if ([_dataWayString isEqualToString:@"isEditWay"]) {
        
        
        
        //  show the list Expand or Income
        //        if (_isCategoryExpand) {
        //            NSMutableArray *categoryColor_Array = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"categoryColor_Expand"]];
        //            _categoryColor = [categoryColor_Array objectAtIndex:_currentCategoryIndex];
        //        } else {
        //            NSMutableArray *categoryColor_Array = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"categoryColor_Income"]];
        //            _categoryColor = [categoryColor_Array objectAtIndex:_currentCategoryIndex];
        //        }
        
        //  categoryName - detailCategoryName
        [_iconCategory setTitle:@"" forState:UIControlStateNormal];
        [_iconDetailCategory setTitle:@"" forState:UIControlStateNormal];
        
        _iconCategoryImageview.image = [UIImage imageNamed:_categoryImageFileName];
        _iconDetailCategoryImageview.image = [UIImage imageNamed:_detailCategoryImageFileName];
        _iconCategoryLabel.text = _categoryName;
        _iconDetailCategoryLabel.text = _detailCategoryName;
        _iconCategory.backgroundColor = [UIColor colorWithHexString:_categoryColor];
        _iconDetailCategory.backgroundColor = [UIColor colorWithHexString:_categoryColor];
        
        //  cost
        _costTextField.text = [NSString stringWithFormat:@"%@", _cost];
        //  dataName
        _dataNameTextField.text = _dataName;
        //  location
        _locationTextField.text = _location;
        //  date
        NSDate *date = [NSDate date];   //  just display current date
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        //    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString *currentDate = [formatter stringFromDate:date];
        [_dateBtn setTitle:[NSString stringWithFormat:@"%@",currentDate] forState:UIControlStateNormal];
        
        //  manageProject
        [_managerProjectNameBtn setTitle:@"Default Project" forState:UIControlStateNormal];
        _dateTextField.placeholder = currentDate;
        
        
        //  made Btn
        //        [self btnSetting:_iconCategory withString:_categoryName withImage:_categoryImageFileName];
        //        [self btnSetting:_iconDetailCategory withString:_detailCategoryName withImage:_detailCategoryImageFileName];
        //        NSLog(@"\n _categoryImageFileName: %@, _detailCategoryImageFileName: %@", _categoryImageFileName, _detailCategoryImageFileName);
        
        
    } else if ([_dataWayString isEqualToString:@"isNewWay"]) {
        //  show the list Expand or Income
        if (_isCategoryExpand) {
            _iconCategory.backgroundColor = [UIColor colorWithHexString:@"#cc3300"];
            _iconDetailCategory.backgroundColor = [UIColor colorWithHexString:@"#cc3300"];
            
        } else {
            _iconCategory.backgroundColor = [UIColor colorWithHexString:@"#006600"];
            _iconDetailCategory.backgroundColor = [UIColor colorWithHexString:@"#006600"];
            
        }
        
        //  categoryName - detailCategoryName
        _iconCategory.titleLabel.text = _categoryName;
        _iconDetailCategory.titleLabel.text = _detailCategoryName;
        //  cost
        _costTextField.placeholder = [NSString stringWithFormat:@"消費金額"];
        //  dataName
        _dataNameTextField.placeholder = [NSString stringWithFormat:@"一個描述名稱"];
        //  cost location
        _locationTextField.placeholder = [NSString stringWithFormat:@"消費的商家或地點"];
        //  date
        _updateTime = [NSDate date];    //  for CoreData sort
        NSDate *date = [NSDate date];   //  just display current date
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        //    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString *currentDate = [formatter stringFromDate:date];
        [_dateBtn setTitle:[NSString stringWithFormat:@"%@",currentDate] forState:UIControlStateNormal];
        
        //  manageProject
        [_managerProjectNameBtn setTitle:@"Default Project" forState:UIControlStateNormal];
        _dateTextField.placeholder = currentDate;
        
        _iconCategoryLabel.text = @"";
        _iconDetailCategoryLabel.text = @"";
        
        //  Test
        NSLog(@"_isCategoryExpand: %d", _isCategoryExpand);
        NSLog(@"categoryColor: %@", _categoryColor);
        
        //  category, detailCategory: imageView, labelString
        //        [self btnSetting:_iconCategory withString:_categoryName withImage:[NSString stringWithFormat:@"0-%@", _categoryName]];
        //        [self btnSetting:_iconDetailCategory withString:_detailCategoryName withImage:[NSString stringWithFormat:@"%ld-%@",  _currentDetailCategoryIndex + 1, _detailCategoryName]];
    }else {
        NSLog(@"ERROR!! DataWayString Not correct!");
    }
    
    // NSNotification
    //  update NSNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCategory:) name:@"updateCategory" object:nil];
    
    
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Methods
-(void) updateCategory: (NSNotification *)notification {
    
    //    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    //    [appDelegate getPathWithAppDelegateProperty];
    //
    //    // Read all plist var at CashPropertyList.plist
    //    NSMutableDictionary *cashPropertyList = [NSMutableDictionary dictionaryWithContentsOfFile:appDelegate.plistFilePath];
    //    NSMutableDictionary *categoryData = [cashPropertyList objectForKey:@"categoryData"];
    //
    //    //  show the list Expand or Income
    //
    //        if ([_currentExpressObject.isExpandItem isEqualToNumber:[NSNumber numberWithBool:YES]]) {
    //        NSMutableArray *categoryColor_Array = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"categoryColor_Expand"]];
    //        _categoryColor = [categoryColor_Array objectAtIndex:_currentCategoryIndex];
    //
    //
    //    } else {
    //        NSMutableArray *categoryColor_Array = [NSMutableArray arrayWithArray:[categoryData objectForKey:@"categoryColor_Income"]];
    //        _categoryColor = [categoryColor_Array objectAtIndex:_currentCategoryIndex];
    //
    //    }
    
    //
    _iconCategory.backgroundColor = [UIColor colorWithHexString:_currentExpressObject.categoryColor];
    _iconDetailCategory.backgroundColor = [UIColor colorWithHexString:_currentExpressObject.categoryColor];
    
    [_iconCategory setTitle:@"" forState:UIControlStateNormal];
    [_iconDetailCategory setTitle:@"" forState:UIControlStateNormal];
    
    _iconCategoryLabel.text = _currentExpressObject.categoryName;
    _iconDetailCategoryLabel.text = _currentExpressObject.detailCategoryName;
    
    _iconCategoryImageview.image = [UIImage imageNamed: _currentExpressObject.categoryImageFileName];
    _iconDetailCategoryImageview.image = [UIImage imageNamed:_currentExpressObject.detailCategoryImageFileName];
    
    //    [self btnSetting:_iconCategory withString:_currentExpressObject.categoryName withImage:_categoryImageFileName];
    //    [self btnSetting:_iconDetailCategory withString:_currentExpressObject.detailCategoryName withImage:_detailCategoryImageFileName];
    
    
    
    
}

-(void)chooseDate:(UIDatePicker *)datePicker
{
    NSDate *date = datePicker.date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"YYYY-MM-dd"];
    _dateTextField.text = [df stringFromDate:date];
    
}



#pragma mark -IBAction
- (IBAction)catogoryBtnPressed:(id)sender {
    
}

- (IBAction)detailCatogoryBtnPressed:(id)sender {
    
    if (_currentExpressObject.categoryImageFileName) {
        
        _currentExpressObject.isCategoryIconExist = [NSNumber numberWithBool:YES];
        
        [self performSegueWithIdentifier:@"toDetailCategory" sender:self ];
    } else {
        NSLog(@"請先選取 主類別");
    }
}

- (IBAction)textFieldEditing:(UITextField *)sender {
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    NSLocale *datelocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_TW"];
    datePicker.locale = datelocale;
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    
    sender.inputView = datePicker;
    
    
}

- (IBAction)dateBtnPressed:(id)sender {
    
}

- (IBAction)managerProjectNameBtnPressed:(id)sender {
    
}

- (IBAction)saveNaviBarBtnPressed:(id)sender {
    //  alloc - Model DatailData
    //    detailData = [[DetailData alloc] init];
    
    NSManagedObjectContext *context = [CoreDataHelper sharedInstance].managedObjectContext;
    DetailData *detailData;
    
    //    //  如果要分 edit way, init way時
    //    if ([_comeFromVCName isEqualToString:@"RankingVC"]) {
    //
    //        _currentDetailData.categoryName = _categoryName;
    //        _currentDetailData.detailCategoryName = _detailCategoryName;
    //
    //        _currentDetailData.dataName = _dataNameTextField.text;
    //        _currentDetailData.location = _locationTextField.text;
    //        _currentDetailData.manageProject = _managerProjectNameBtn.titleLabel.text;
    //        _currentDetailData.categoryColor = _categoryColor;
    //        _currentDetailData.categoryImageFileName = _categoryImageFileName;
    //        _currentDetailData.detailCategoryImageFileName = _detailCategoryImageFileName;
    //
    //        //  NSDate
    //        _currentDetailData.updateTime = _updateTime;
    //
    //        //  NSNumber
    //        //  需要 "除錯機制"
    //        _currentDetailData.cost = [[[NSNumberFormatter alloc] init] numberFromString:_costTextField.text];
    //        _currentDetailData.isExpandItem = [NSNumber numberWithBool:_isCategoryExpand];
    //
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"DetailDataUpdated" object:nil userInfo:@{@"detailData":_currentDetailData}];
    //
    //    } else {
    //        //
    //    }
    
    //  Core Data
    
    if ([_dataWayString isEqualToString:@"isEditWay"]) {
        
        //  修改
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"DetailData" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        
        //        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"updateTime == %@",[NSString stringWithFormat:@"%@",_updateTime]];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"updateTime == %@",_updateTime];
        
        [fetchRequest setPredicate:predicate];
        
        NSArray *fetchArray = [context executeFetchRequest:fetchRequest error:nil];
        
        detailData = fetchArray[0];
        
    } else {
        //  新增
        detailData = [NSEntityDescription insertNewObjectForEntityForName:@"DetailData" inManagedObjectContext:context];
        
    }
    
    
    
    //  Model - DetailData
    //  NSString
    
    //    detailData.categoryName = _categoryName;
    //    detailData.detailCategoryName = _detailCategoryName;
    detailData.categoryName = _currentExpressObject.categoryName;
    detailData.detailCategoryName = _currentExpressObject.detailCategoryName;
    
    detailData.dataName = _dataNameTextField.text;
    detailData.location = _locationTextField.text;
    detailData.manageProject = _managerProjectNameBtn.titleLabel.text ;
    detailData.categoryColor = _currentExpressObject.categoryColor;
    
    detailData.categoryImageFileName = [NSString stringWithFormat:@"0-%@", _currentExpressObject.categoryName];
    //    detailData.detailCategoryImageFileName = [NSString stringWithFormat:@"%ld-%@",  _currentDetailCategoryIndex + 1, _currentExpressObject.detailCategoryName];
    detailData.categoryImageFileName = _currentExpressObject.categoryImageFileName;
    detailData.detailCategoryImageFileName = _currentExpressObject.detailCategoryImageFileName;
    
    //  NSDate
    detailData.updateTime = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"YYYY-MM-dd"];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setDateFormat:@"YYYY-MM-dd"];
//    detailData.strDate = [formatter stringFromDate:detailData.updateTime];
    if ([_dateTextField.text isEqualToString:@""]) {
        NSLog(@"%@",_dateTextField.placeholder);

        detailData.strDate = _dateTextField.placeholder;
    } else {
        detailData.strDate = _dateTextField.text;

    }
    
    NSLog(@"%@",detailData.strDate);

    
    //  NSNumber
    //  需要 "除錯機制"
    detailData.cost = [[[NSNumberFormatter alloc] init] numberFromString:_costTextField.text];
    detailData.isExpandItem = [NSNumber numberWithBool:_isCategoryExpand];
    detailData.categoryArrayIndex = _currentExpressObject.categoryArrayIndex;
    
    //  Test detailData property
    NSLog(@"detailData.categoryName: %@", detailData.categoryName);
    NSLog(@"detailData.detailCategory: %@", detailData.detailCategoryName);
    NSLog(@"detailData.dataName: %@",detailData.dataName);
    NSLog(@"detailData.location: %@", detailData.location);
    NSLog(@"detailData.manageProject: %@", detailData.manageProject);
    NSLog(@"%@", detailData.updateTime);
    NSLog(@"%@", detailData.cost);
    NSLog(@"%ld", [detailData.cost integerValue]);
    NSLog(@"detailData.isExpandItem : %@, _isCategoryExpand : %d", detailData.isExpandItem, _isCategoryExpand);
    
    NSRange rangeY = NSMakeRange (0, 4);
    NSRange rangeM = NSMakeRange (5, 2);
    NSRange rangeD = NSMakeRange (8, 2);
    
    NSLog(@"strDate: %@",detailData.strDate);
    NSLog(@"Year: %@",[detailData.strDate substringWithRange:rangeY]);
    NSLog(@"Month: %@",[detailData.strDate substringWithRange:rangeM]);
    NSLog(@"Day: %@",[detailData.strDate substringWithRange:rangeD]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DetailDataUpdated" object:nil userInfo:@{@"detailData":detailData}];
    
    //  Save
    NSError *error = nil;
    [context save:&error];
    if (error) {
        NSLog(@"ERROR!! %@",error);
    }

    //    //  delegate 方法
    //    //    @optional, 要檢查有沒有該方法
    //    if([self.delegate respondsToSelector:@selector(didFinishUpdateDeatilData:)]){
    //        [self.delegate didFinishUpdateDeatilData:_currentDetailData];
    //    }
    //
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (IBAction)cancelNaviBarBtnPressed:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark Setting viewBtn Basic Attributes
-(void) btnSetting:(UIButton *)btnView withString:(NSString *)labelstring withImage:(NSString *)imageName  {
    
    CGSize btnSize = [btnView bounds].size;
    CGFloat btnWidth = btnSize.width;
    CGFloat btnHeight = btnSize.height;
    
    //  imageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    
    imageView.frame = CGRectMake(btnWidth/6, btnHeight/8, btnWidth/3*2, btnWidth/3*2);
    [btnView setContentMode:UIViewContentModeScaleAspectFit];
    [btnView addSubview:imageView];
    
    //  label
    UILabel *stringLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, btnHeight/10*8, btnWidth, btnWidth/7)];
    stringLabel.text = [NSString stringWithFormat:@"%@", labelstring];
    stringLabel.textAlignment = NSTextAlignmentCenter;
    stringLabel.textColor = [UIColor whiteColor];
    
    [btnView setContentMode:UIViewContentModeScaleAspectFit];
    [btnView addSubview:stringLabel];
    [self.view addSubview:btnView];
    
    btnView.layer.cornerRadius = btnWidth/5;
    //    NSLog(@"%.1f", btnView.layer.cornerRadius);
    btnView.layer.masksToBounds = YES;
    
    btnView.backgroundColor = [UIColor colorWithHexString:_categoryColor];
    
}

#pragma mark -Method for TextField
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField) {
        currentTextField = textField;   //  抓取現在的textField
    } else {
        currentTextField = nil;
    }
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [currentTextField resignFirstResponder]; // 關閉現在textField的鍵盤
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toCategory"]) {
        
        CategoryTableViewController *tableVC = segue.destinationViewController;
        tableVC.isCategoryExpand = _isCategoryExpand;
        tableVC.currentExpressObject = _currentExpressObject;
    }
    
    if ([segue.identifier isEqualToString:@"toDetailCategory"]) {
        //  _categoryName is exist
        
        DetailCategoryTableViewController *tableVC = segue.destinationViewController;
        tableVC.isCategoryExpand = _isCategoryExpand;
        tableVC.currentExpressObject = _currentExpressObject;
        
        
    }
}

@end
