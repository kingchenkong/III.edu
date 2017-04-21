//
//  NoteListViewController.m
//  NoteApp
//
//  Created by 陳維漢 on 2016/6/16.
//  Copyright © 2016年 陳維漢. All rights reserved.


#import "NoteListViewController.h"
#import "Note.h"
#import "NoteCell.h"
#import "NoteViewController.h"
#import "CoreDataHelper.h"
@import MessageUI;
@import GoogleMobileAds;    // 橫幅廣告
@import Firebase;

@interface NoteListViewController ()    <UITableViewDataSource,UITableViewDelegate,NoteViewControllerDelegate,GADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) NSMutableArray *notes;

@property(nonatomic) GADBannerView *bannerview;    //  橫幅廣告

@end

@implementation NoteListViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        //        self.notes = [NSMutableArray array];
        //  [self loadFromFile];    //  Archiving
        [self loadFromCoreData];    //  CoreData
        //
        //        for ( int i=0 ; i < 10 ; i++){
        //            Note *note = [[Note alloc]init];
        //            note.text = [NSString stringWithFormat:@"Note %d",i];
        //            [self.notes addObject:note];
        //        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishUpdate:) name:@"NoteUpdated" object:nil];
        
        
    }
    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//  通知的做法
-(void)finishUpdate:(NSNotification *)notification{
    
    Note *note = notification.userInfo[@"note"];
    
    //  find Array id
    NSUInteger index = [self.notes indexOfObject:note];
    //  build NSIndexPath
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    //  reload this data
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //    self.tableView.estimatedRowHeight = 50;
    //    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = NSLocalizedString(@"list", @"");
    
    //橫幅廣告
    self.bannerview = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
//    self.bannerview.adUnitID = @"ca-app-pub-7678691608040665/5984498636";
    self.bannerview.adUnitID = @"ca-app-pub-1521801495507235/5775461901";
    
    self.bannerview.delegate = self;
    
    self.bannerview.rootViewController = self;
    [self.bannerview loadRequest:[GADRequest request]];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSString * key = @"showThanks";
    BOOL showed = [[NSUserDefaults standardUserDefaults] boolForKey:key];
    if ( !showed ) {    //  如果沒顯示過, 就跳出視窗
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Thank for your purchasing" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showThanks"];   //  將值 寫入 user defaults
            [[NSUserDefaults standardUserDefaults]synchronize]; //  synchronize 強制寫入硬碟, 通常不用
        }];
        
        [alertController addAction:action]; //  alert controller 要用 presnet形式來顯示
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}

- (IBAction)edit:(id)sender {
    
    //    self.tableView.editing = !self.tableView.editing;
    //    [self.tableView setEditing:!self.tableView.editing];
    [self.tableView setEditing: !self.tableView.editing animated:YES];
    
}

- (IBAction)addNote:(id)sender {
    
    [FIRAnalytics logEventWithName:@"add_Note" parameters:@{}];
    
    CoreDataHelper * helper = [CoreDataHelper sharedInstance];
    
    
    //   數量位置都要對
    //  Note *note = [[Note alloc] init];
    // CoreData 修改
    Note * note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:helper.managedObjectContext];
    
//    note.text = @"New Note";
    
    note.text = NSLocalizedString(@"new.note", @"");
    //    [self.notes addObject:note];
    
    //   產生位置物件
    //    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.notes.count-1 inSection:0];    //  新增在最後一筆
    
    [self.notes insertObject: note atIndex:0];
    //  Archiving
    //    [self saveToFile];
    //  CoreData
    [self saveToCoreData];
    //
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];   //  新增在第0筆
    //   呼叫tableView 新增
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

    //  要求評論
-(void)askForRating{
    
    
    UIAlertController *askController = [UIAlertController alertControllerWithTitle:@"Hello App User" message:@"If you like this app,please rate in App Store. Thanks." preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"我要評價" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *appID = @"12345556";
        NSString *ratingUrl = [NSString
                               stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",appID];
        NSURL *url = [NSURL URLWithString:ratingUrl];
        [[UIApplication sharedApplication] openURL:url];
    }];
    
    UIAlertAction *laterAction = [UIAlertAction actionWithTitle:@"稍候再評" style:UIAlertActionStyleDefault handler:nil];
    [askController addAction:laterAction];
    [askController addAction:okAction];
    [self presentViewController:askController animated:YES completion:nil];
    
}
    //  email 詢問建議
- (IBAction)help:(id)sender {
    
    if ( ![MFMailComposeViewController canSendMail]){
        NSLog(@"mail沒有設定");
        return;
    }
    
    MFMailComposeViewController *mcvc = [[MFMailComposeViewController alloc] init];
    mcvc.mailComposeDelegate = self;
    mcvc.title = @"I have qusetion";
    [mcvc setSubject:@"I have qusetion"];
    //應用程式版本，Target裏的Version
    NSString *version = [[NSBundle mainBundle]
                         objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *machine = [[UIDevice currentDevice] model];
    
    NSString *productName = [[NSBundle mainBundle]
                             objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    NSString *defaultBody = [NSString stringWithFormat:@"<br><br/><br/>Product: %@(%@)<br/>Device:%@",productName,version,machine];
    [mcvc setMessageBody:defaultBody isHTML:YES];
    //提供支援email
    NSString *email = @"yourEmailSupport@hotmail.com";
    //設定收件人
    [mcvc setToRecipients:[NSArray arrayWithObject:email]];
    [self presentViewController:mcvc animated:YES completion:nil];
}

    //  email 詢問建議
#pragma mark MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    NSString *resultTitle = nil;
    NSString *resultMsg = nil;
    switch (result) {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            resultTitle = @"Email Saved";
            resultMsg = @"You saved the email as a draft";
            break;
        case MFMailComposeResultSent:
            resultTitle = @"Email Sent";
            resultMsg = @"Your email was successfully delivered";
            break;
        case MFMailComposeResultFailed:
            resultTitle = @"Email Failed";
            resultMsg = @"Sorry, the Mail Composer failed. Please try again.";
            break;
        default:
            resultTitle = @"Email Not Sent";
            resultMsg = @"Sorry, an error occurred. Your email could not be sent."; break;
    }
    if ( resultTitle ){
        UIAlertView *mailAlertView = [[UIAlertView alloc] initWithTitle:resultTitle
                                                                message:resultMsg delegate:self
                                                      cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [mailAlertView show];
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark CoreData
-(void)saveToCoreData{
    CoreDataHelper * helper = [CoreDataHelper sharedInstance];
    
    NSError * error = nil;
    [helper.managedObjectContext save:&error];
    if (error) {
        NSLog(@"error saving %@",error);
    }
    
    
}
-(void)loadFromCoreData{
    CoreDataHelper * helper = [CoreDataHelper sharedInstance];
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Note"]; //  指定要查詢的Entity
    
    //     sort
    //  根據text欄位 由小到大排序
    NSSortDescriptor * sortByText = [NSSortDescriptor sortDescriptorWithKey:@"text" ascending:YES];
    
    [request setSortDescriptors:@[sortByText]];
    //
    
    NSError * error = nil;
    
    NSArray * results = [helper.managedObjectContext executeFetchRequest:request error:&error];
    
    if(error){  //  有錯誤, 則印錯誤 產生空的notes
        NSLog(@"error %@",error);
        self.notes = [ NSMutableArray array];
    }else{  //  沒有錯誤,則放入notes array中
        self.notes = [ NSMutableArray arrayWithArray:results];
    }
    
    
}
#pragma mark GCD
- (IBAction)upload:(id)sender {
    
//    NSArray * empty = @[];
//    empty[0];
    
    UIBarButtonItem * item = sender;
    
    UIActivityIndicatorView *indicatorView =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    item.customView = indicatorView;
    [indicatorView startAnimating];
    
    
    //  非同步 queue
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //  欲在背景執行的程式
        //  just 模擬執行網路作業 3 sec.
        [NSThread sleepForTimeInterval:3];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            item.customView = nil;
        });
    });
    
}




#pragma mark Archiving
-(void)saveToFile{
    //  save Documents
    NSString * docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //  Archiving的檔案路徑,檔名: notes.archive
    NSString * filePath = [docPath stringByAppendingPathComponent:@"notes.archive"];
    //  save file
    [NSKeyedArchiver archiveRootObject:self.notes toFile:filePath];
}

-(void)loadFromFile{
    //  save Documents
    NSString * docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //  Archiving的檔案路徑,檔名: notes.archive
    NSString * filePath = [docPath stringByAppendingPathComponent:@"notes.archive"];
    
    NSArray * data = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    self.notes = [NSMutableArray arrayWithArray:data];  //  轉成 NSMutableArray
    
    
}



#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.notes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //  custom cell
    //    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customcell"forIndexPath:indexPath];
    //    Note *note = self.notes[indexPath.row];
    //    cell.mainLabel.text = note.text
    //    ;
    //    return cell;
    
    
    //  Teacher's Demo
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Note *note = self.notes[indexPath.row];
    cell.textLabel.text = note.text;
    cell.imageView.image = [note thumbnailImage];
    cell.showsReorderControl = YES;
    
    NSDate *nowDate = [NSDate date];    //  取得目前時間
    
    cell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:nowDate dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.accessoryView = [[UISwitch alloc]init];  //  客製化
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Note * note = self.notes[indexPath.row];
        CoreDataHelper * helper = [CoreDataHelper sharedInstance];
        [helper.managedObjectContext deleteObject:note];
        [self saveToCoreData];
        
        [self.notes removeObjectAtIndex:indexPath.row];
        //  Archiving 部份
        //  [self saveToFile];
        //
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    Note *note = self.notes[sourceIndexPath.row];

    [self.notes removeObject:note];
    [self.notes insertObject:note atIndex:destinationIndexPath.row];

    //  Archiving
    //    [self saveToFile];
    //  CoreData 做搬移比較難 考試寫出來會加分 ！！！！！！！！
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSLog(@"%ld 筆被按到",(long)indexPath.row);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  //  使被選取放開後的"灰底"-消失
    
    //    NoteViewController *noteViewController =
    //    [self.storyboard instantiateViewControllerWithIdentifier:@"noteViewController"];
    //    [self.navigationController pushViewController:noteViewController animated:YES];
    
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

//  In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"noteSegue"]) {
        //      NoteViewController
        NoteViewController *noteViewController = segue.destinationViewController;
        //      取得使用者點選位置
        NSIndexPath * indexPath = self.tableView.indexPathForSelectedRow;
        //      將該位置Note傳給下一個畫面
        noteViewController.currentNote = self.notes[indexPath.row];
        noteViewController.delegate = self;
        //  noteViewController.delagete = NoteListViewController;
        
    }
}

//      protocol的做法
-(void)didFinishUpdateNote:(Note*)note{
    //  find Array id
    NSUInteger index = [self.notes indexOfObject:note];
    //  build NSIndexPath
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    //  reload this data
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //  Archiving
    //    [self saveToFile];
    [self saveToCoreData];
}


//  橫幅廣告
#pragma mark GADBannerViewDelegate
//收到廣告會呼叫此方法
-(void)adViewDidReceiveAd:(GADBannerView *)bannerView{
    
    if ( !bannerView.superview ){
        self.tableView.tableHeaderView = bannerView;
    }
    
    
    
}






@end
