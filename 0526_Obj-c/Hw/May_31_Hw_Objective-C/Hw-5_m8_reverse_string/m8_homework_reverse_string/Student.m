//  Student.m
#import "Student.h"

@implementation Student

+( NSString * ) reverse:(NSString *) str
{
    NSString *  rv = @"";
    NSString *  rv_stack = @"";
    NSString * str_catch;
    NSRange index ;
    
    rv = str;   //str 是初值
    NSLog(@"Original string: %@",str);
// fix 練習二 #2 請將 str 字串頭尾顛倒,
//  再將結果字串當作傳回值回傳
//  請寫在這裡
    index = [ str rangeOfString: str];
    NSUInteger i ;
    for(i= index.length;i>0;i-=1){
        str_catch = [str substringWithRange:NSMakeRange(i-1, 1)];
        //NSLog(@"%@",str_catch);   // print 擷取的段落
        rv_stack = [rv_stack stringByAppendingString:str_catch];
        //NSLog(@"%@",rv2);         // print 堆疊
    }
    rv =rv_stack;
    //  已完成的字串
    return   rv;
}


@end
