//  ViewController.m
//  m8_homework_string_range
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//      宣告區
    NSString * rv = @"That student in this room is studying hard"  ;
    NSString * aString = @"student" ;
    NSRange  found ;
//

    
//  --------------------    主程式     --------------------
    NSLog(@"開始");
    NSLog(@"@@@@@@@@@@@@@@@@");
// fix 練習一 #1
//              請在此 rv 字串中找出出現 aString 字串物件的範圍
//              註: 出現的範圍  請用 NSRange 來表示
//     請寫在這裡

    found = [rv rangeOfString:aString];
        //  格式:  NSRange_var = [ str_var1 rangeOfString: str_var2 ];
    NSLog(@"位置：%lu || 字串相同長度：%lu", found.location, found.length);
        // found.location, found.length 是 NSUInteger 資料型態 用%lu

    
// End
    NSLog(@"################");
    NSLog(@"Hello, World!");
}

@end
