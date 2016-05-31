//  ViewController.m
//  m8_homework_string_init
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * T = @"student" ;
    int       N        = arc4random()%16 + 1;       //  random int
    NSString * R  ;
    NSLog(@"開始");
//
// fix 練習一 #1 請將 T 所參考到的字串後面
//      , 串接 N 變數所代表的整數內容
//      請將串接的結果字串存到 R 變數
//    
//     請寫在這裡
    
    
    NSLog(@"###############");
    NSLog(@"R_0= %@", R );
    NSLog(@"$$$$$$$$$$$$$$$");
    NSString * S;
    S = [NSString stringWithFormat:@"%@%d", T, N ];     // 這是一種做法 用別種
    NSLog(@"S = %@",S);
    
//    NSString * n_str = [[NSString alloc] initWithFormat:@"%d", N];
//    NSLog(@"n_str = %@",n_str);
    
    R = T;
    NSLog(@"R=T 之後 R= %@", R );
//    R = [R stringByAppendingFormat:@"%@",n_str];
//    NSLog(@"R_2= %@", R );
    R = [R stringByAppendingFormat:@"%d",N];
    NSLog(@"R strByAppend後  R= %@", R );
    
    
    
    BOOL 是ㄧ樣的 = NO;
    是ㄧ樣的 =  [ R isEqualToString: S ];
    if(是ㄧ樣的) {
        NSLog(@"是ㄧ樣的, R 是 %@  而 S 是 %@", R, S);
    } else {
        NSLog(@"不ㄧ樣,   R 是 %@  而 S 是 %@", R, S );
    }
    NSLog(@"&&&&&&&&&&&&&&&");
    NSLog(@"結束");
    
}

@end
