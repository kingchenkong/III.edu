//
//  NoteViewController.m
//  NoteApp
//
//  Created by 陳維漢 on 2016/6/16.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import "NoteViewController.h"
@import GoogleMobileAds;    //  插頁式廣告


@interface NoteViewController ()    <UINavigationControllerDelegate, UIImagePickerControllerDelegate,GADInterstitialDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (nonatomic)   BOOL isNewImage;
@property (nonatomic)   NSLayoutConstraint * imageConstriaint;

@property (nonatomic) GADInterstitial *interstitial;    //  插頁式廣告

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.text = self.currentNote.text;
    self.imageView.image = self.currentNote.image;
    
    if (self.currentNote.imageName) {
        
        self.imageView.layer.borderWidth = 1;
        self.imageView.layer.borderColor = [UIColor blueColor].CGColor;
        
        self.imageView.layer.cornerRadius = 10;
        self.imageView.layer.masksToBounds = YES;
    }
    
    //  加入 4:3 寬高比條件
    NSLayoutConstraint *ratioConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.imageView
                                           attribute:NSLayoutAttributeHeight
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.imageView
                                           attribute:NSLayoutAttributeWidth
                                           multiplier:0.75
                                           constant:0];
    //  加在imageView上
    //    [self.imageView addConstraint:ratioConstraint];
    //  直向時才能打開這個條件
    if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
    ratioConstraint.active = YES;   //  簡單
    }
    
    self.imageConstriaint = ratioConstraint;
    
    NSLog(@"toolBar intricsic contensize %@", NSStringFromCGSize(self.toolbar.intrinsicContentSize));
        //  回傳 toolbar (寬,高) = {-1,44}  -1:表示無法決定
    NSLog(@"imageView intricsic contensize %@", NSStringFromCGSize(self.imageView.intrinsicContentSize));
    
    //  插頁式廣告
//    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-7678691608040665/5705297030"];
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-1521801495507235/2542793906"];
    //ca-app-pub-1521801495507235/2542793906 測試用
    
    self.interstitial.delegate = self;
    [self.interstitial loadRequest:[GADRequest request]];
    
    
    /*
     //lab2, use all programing
     //移除所有在storyboard中設定的constraints
     //[self.view removeConstraints:self.view.constraints];
     //設定toolbar 水平，左右兩邊沒有間距 |[toolbar]|
     NSArray *hToolbars = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[toolbar]|" options:0 metrics:0 views:@{@"toolbar":self.toolbar}];
     //設定toolbar 垂直，下方貼齊邊界 [toolbar]|
     NSArray *vToolbars = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[toolbar]|" options:0 metrics:0 views:@{@"toolbar":self.toolbar}];
     [NSLayoutConstraint activateConstraints:hToolbars];
     [NSLayoutConstraint activateConstraints:vToolbars];
     //[self.view addConstraints:hToolbars];
     //[self.view addConstraints:vToolbars];
     
     //設定imageView水平，左右兩邊為系統設定間距|-[imageView]-|
     NSArray *hImage = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[imageView]-(10)-|" options:0 metrics:0 views:@{@"imageView":self.imageView}];
     //設定imageView垂直，下方距toolbar為10,[imageView]-(10)-[toolbar]
     NSArray *vImage = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView]-(10)-[toolbar]" options:0 metrics:0 views:@{@"imageView":self.imageView,@"toolbar":self.toolbar}];
     [NSLayoutConstraint activateConstraints:hImage];[NSLayoutConstraint activateConstraints:vImage];
     //    [self.view addConstraints:hImage];
     //    [self.view addConstraints:vImage];
     
     //設定imageView的長寬比最多為0.75
     NSLayoutConstraint *imageRatio = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeWidth multiplier:0.75 constant:0];
     //[self.imageView addConstraint:imageRatio];
     [NSLayoutConstraint activateConstraints:imageRatio];
     
     //設定textView水平，左右兩邊為設定間距|-(10)-[imageView]-(10)-|
     NSArray *hText = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[textView]-(10)-|" options:0 metrics:0 views:@{@"textView":self.textView}];
     //設定textView垂直，上方距離topLayout 10,下方距離imageView為系統預設間距[toplayout]-(10)-[textView]-(10)-[imageView]
     NSArray *vText = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[toplayout]-(10)-[textView]-(10)-[imageView]" options:0 metrics:0 views:@{@"textView":self.textView,@"imag	eView":self.imageView,@"toplayout":self.topLayoutGuide}];
     //擇一使用
     [NSLayoutConstraint activateConstraints:hText];
     [NSLayoutConstraint activateConstraints:vText];
     //[self.view addConstraints:hText];
     //[self.view addConstraints:vText];
    */
    
}

//  轉向時 垂直向的size class 會變更
-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    //  要呼叫super
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        //  垂直向變成compact, 表示橫向
        //  拿掉 4:3 條件
        self.imageConstriaint.active = NO;
    }else{
        //  直向時, 4:3 條件要成立
        self.imageConstriaint.active = YES;
    }
    
    //  invalidateIntrinsicContentSize 有變動, 須重新計算
    [self.toolbar invalidateIntrinsicContentSize];
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)camera:(id)sender {
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
    
    
}

- (IBAction)done:(id)sender {
    
    self.currentNote.text = self.textView.text;
    //    self.currentNote.image = self.imageView.image;
    
    
    if (self.isNewImage) {
        //  轉成NSData => JPEG
        //  存到Document, 利用UUID產生不一樣的檔名  //  UUID,是一種用日期,時間...等時間產生的 隨機亂碼 （通常36位數
        NSUUID *uuid = [NSUUID UUID];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[uuid UUIDString]];       //  製造 "UUID" .jpg
        NSString *documentsPath =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];   //   抓 home/Documents/ 的路徑
        NSString *imagePath = [documentsPath stringByAppendingPathComponent:fileName];  //  抓"UUID" .jpg 路徑 在 home/Documents/底下
        NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 1); // 將檔案 轉成Binary (JPEG) 的檔案, 0~1 是 quality
        [imageData writeToFile:imagePath atomically:YES];   // 存入檔案, atomically 是 先將檔案寫入暫存檔,確認完成才存入
        self.currentNote.imageName = fileName;  //  記錄檔名
        
        NSLog(@"home = %@",NSHomeDirectory());  //  把Home       位置印出來
        NSLog(@"imagePath = %@",imagePath);     //  把imagePath  位置印出來
        
    }
    
    
    //  delegate 方法
    //    @optional, 要檢查有沒有該方法
    if([self.delegate respondsToSelector:@selector(didFinishUpdateNote:)]){
        [self.delegate didFinishUpdateNote:self.currentNote];
    }
    
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"NoteUpdated" object:nil userInfo:@{@"note":self.currentNote}];
    
    // [self.navigationController popViewControllerAnimated: YES];
    
    //  插頁式廣告
    if (self.interstitial.isReady) {
        //  有廣告 跳廣告
        [self.interstitial presentFromRootViewController:self];
    }else{
        //  如果載入不到廣告,則跳回前一頁
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark GADInterstitialDelegate
-(void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    //  按Ｘ
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)interstitialWillLeaveApplication:(GADInterstitial *)ad{
    //  點廣告
    [self dismissViewControllerAnimated:YES completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}



#pragma mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    //  get user 選擇的照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //  put on the imageView
    self.imageView.image = image;
    //  close pictrue controller
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //  為了一點選 照片 就會有邊框
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.borderColor = [UIColor blueColor].CGColor;
    
    //  讓照片 變成圓角
    self.imageView.layer.cornerRadius = 10;     //  變成 圓角
    self.imageView.layer.masksToBounds = YES;
    
    
    self.isNewImage = YES;
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
