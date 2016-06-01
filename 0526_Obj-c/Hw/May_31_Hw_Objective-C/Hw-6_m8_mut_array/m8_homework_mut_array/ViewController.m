//  ViewController.m
//  m8_homework_mut_array
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Let's begin~");
    NSMutableArray  * mutArr;
    mutArr = [ NSMutableArray new ] ;
    NSUInteger luckyNumber;
    
    [ mutArr addObject:@"曾X翔" ];
    [ mutArr addObject:@"潘世Y" ];
    [ mutArr addObject:@"張Z鴻" ];
    NSLog(@"Now, we have ###%lu### object in muArr",[mutArr count]);
    NSLog(@"########################");
// fix 練習一 #1  執行此程式, 看會印出什麼?
    for ( int i = 1  ;   i <= 3 ;  i += 1 )
    {
// fix 練習 #2 在上面的 for迴圈中
//   , 隨機從上面三個同學的名子 中抽出ㄧ個名子並印出
//   離開for迴圈時, 抽出的三個同學名子不得重複
//   請寫在這裡, 可利用 arc4random()
        luckyNumber = arc4random()%([mutArr count]) ;                               //  Random pick 0 ~ count-1 某一數
        //  NSLog(@"luckyNumber is %lu",luckyNumber);                               //  [test] luckyNumber
        NSLog(@"Lucky %d is %@",i,[ mutArr objectAtIndex: luckyNumber ]);           //  print lucky No.X and "Name"
        [mutArr removeObjectAtIndex:luckyNumber];                                   //  Remove the lucky "Name" which in the Object
        //NSLog(@"Now, we remaining ###%lu### object in muArr",[mutArr count]);     //  [test] print   we "Remaining" Object
    }  // for 迴圈 結束於此
    NSLog(@"$$$$$$$$$$$$$$$$$$$$$$$$");
    NSLog(@"for 迴圈 播放完畢~ 謝謝收看");
}

@end
