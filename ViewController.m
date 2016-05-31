//  ViewController.m
//  m8_homework_mutable_string
#import "ViewController.h"

#import "Answer.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"開始");
    Answer * bj = [[Answer alloc]init];
    
    NSMutableString * mut_str = [[NSMutableString alloc]initWithFormat:@"\n"];
    
    int howManyLevels = 5;      //  層數
    
    int numberOfBlanks = howManyLevels - 1;
    int numberOfLeaves = 1;
    
    for (int i = 1; i <= howManyLevels; i += 1) {
        
        [ bj appendTo:mut_str HowMany:numberOfBlanks What:@" " ];
        [ bj appendTo:mut_str HowMany:numberOfLeaves What:@"*" ];
        [ bj appendTo:mut_str HowMany:1 What:@"\n" ];
        
        numberOfBlanks -= 1;
        numberOfLeaves += 2;
    }
// fix 練習一 #1  執行此程式, 看會印出什麼?
            //      HomeWork #4 修改段 @ Answer.m
    NSLog(@"%@", [ mut_str description ] );
    
    NSLog(@"Hello, World!");
}

@end
