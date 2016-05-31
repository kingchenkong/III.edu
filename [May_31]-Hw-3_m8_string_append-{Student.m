//  Student.m
#import "Student.h"

@implementation Student

+(NSString *) appendToStr:  (NSString *) str
                  HowMany:  (NSUInteger) howMany
                     What:  (NSString *) what
{
    NSString * rv = str ;
//
// fix 練習二 #2  請在str字串後面
//  , 重複串接 howMany 次 的 what 字串.
//  請將串接的結果字串當作傳回值傳回去
//
//     請寫在這裡
    for (int i=1;i<=howMany;i+=1){
        rv = [rv stringByAppendingString:what];
    }
    //NSLog(@"%@",rv);
    
    
    
    
    return  rv ;
}



@end
