//  ViewController.m
//  m8_homework_string_init
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //      宣告區
    
    NSString * T = @"student" ;
    int       N        = arc4random()%16 + 1;       //  random int
    NSString * R ;
    NSString * S ;
    
    NSLog(@"開始");
    NSLog(@"###############");
    //
    // fix 練習一 #1 請將 T 所參考到的字串後面
    //              , 串接 N 變數所代表的整數內容
    //              請將串接的結果字串存到 R 變數
    NSLog(@"R_0= %@", R );
    NSLog(@"$$$$$$$$$$$$$$$");
    S = [NSString stringWithFormat:@"%@%d", T, N ];     // 這是一種做法 用別種
    NSLog(@"S = %@",S);
    NSLog(@"-------------------以上是老師寫的-------------------");
    //      -------------------以上是老師寫的-------------------
    
    //  Method 1.       --My answer--
    R = [T stringByAppendingFormat:@"%d",N];
    NSLog(@"R AppendingFormat後  R= %@", R );
    
    //  Method 2.
    //    NSString * n_str = [[NSString alloc] initWithFormat:@"%d", N];     // N 轉成字串後 在做字串串接
    //    NSLog(@"n_str = %@",n_str);
    
    
    //      -------------------判斷式-------------------
    BOOL 是ㄧ樣的 = NO;
    是ㄧ樣的 =  [ R isEqualToString: S ];
    if(是ㄧ樣的) {
        NSLog(@"正確 ~ ~ \n R 是 %@  而 S 是 %@", R, S);
    } else {
        NSLog(@"不對喔!! \n  R 是 %@  而 S 是 %@", R, S );
    }
    NSLog(@"&&&&&&&&&&&&&&&");
    NSLog(@"結束");
    
}

@end
