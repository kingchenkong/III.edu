//  ViewController.m
//  m8_homework_reverse_string
#import "ViewController.h"

#import "Student.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * r ;
    NSLog(@"開始");
    r = [ Student reverse: @"IIIStudent2016" ];
// fix 練習一 #1  執行此程式, 看會印出什麼?
    NSLog(@"Reverse string:  %@" , r );
    NSLog(@"結束");
}

@end
