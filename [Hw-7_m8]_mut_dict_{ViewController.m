//  ViewController.m
//  m8_homework_mut_dict
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"-------------Begin-------------");
    
// 名字 價錢 購買數量
    //  iPhone 6s       ：NT$28500 買5個   NT$ 142500
    NSMutableArray * item_1 = [ @[ @"iPhone 6s", [NSNumber numberWithInt: 28500], [NSNumber numberWithInt: 5]] mutableCopy];
    //  Macbook pro 13' ：NT$41900 買2個   NT$ 83800
    NSMutableArray * item_2 = [ @[ @"Macbook pro 13'", [NSNumber numberWithInt: 41900  ], [NSNumber numberWithInt: 2]] mutableCopy];
    //  iPad pro 9.7'   ：NT$20900 買3個   NT$ 62700
    NSMutableArray * item_3 = [ @[ @"iPad pro 9.7'", [NSNumber numberWithInt: 20900], [NSNumber numberWithInt: 3]] mutableCopy];
    
    NSMutableArray * item = [@[item_1,item_2,item_3] mutableCopy];  //  mut_dict "Object" array
    NSMutableArray * dict_KeyValue = [ @[@"No.1",@"No.2",@"No.3"] mutableCopy]; //  mut_dict "KeyValue" array

    //      創造物件法 -- 作業要求
    NSMutableDictionary * mut_dict = [ NSMutableDictionary  new ];
    for (int i =0; i<=dict_KeyValue.count-1; i+=1) {
        [mut_dict setObject: item [i] forKey: dict_KeyValue [i] ];
    }
    
    //      便捷法
//NSDictionary * mut_dict = [ NSDictionary  new ];
//    mut_dict = @{dict_KeyValue [0] : item [0],
//                 dict_KeyValue [1] : item [1],
//                 dict_KeyValue [2] : item [2]  };
    
    // fix 練習  #1
    //  在上面的 NSMutableDictionary 中,
    //   以商品的唯一識別碼字串為鍵值加入 商品的名子
    //   ,單價,及 購買數量.
    //  請加入三個商品

    

//    NSLog(@"mut_dict have %lu obj",[dict_KeyValue count]);  //  [test]  print--      mut_dict obj-Count
//    for(int i = 0;i<=[mut_dict count]-1 ;i+=1 ){            //  [test]  print--      mut_dict obj-Data
//        NSLog(@"%@",[ mut_dict objectForKey:[ dict_KeyValue objectAtIndex: i ] ]);
//    }
    
    // fix 練習  #2
    //  再從上面的 NSMutableDictionary 中
    //  算出三個商品的購買總價
    //   請寫在這裡
    
    int totalCost = 0; //   全部金額
    int eachCost = 0;
    NSNumber        * price     = [[NSNumber        alloc] init];
    NSNumber        * amount    = [[NSNumber        alloc] init];
    NSMutableArray  * thisObj   = [[NSMutableArray  alloc] init];
    
    for (int i = 0; i<= [mut_dict count]-1; i+=1) {
        thisObj = [ mut_dict objectForKey:[ dict_KeyValue objectAtIndex:i ] ] ; //      本項 項目名稱
        price   = [thisObj objectAtIndex: 1] ;  //      本項  價格
        amount  = [thisObj objectAtIndex: 2] ;  //      本項  購賣數量
//        NSLog(@"this Object is %@",[ thisObj objectAtIndex:0]);           //  [test] print 項目
//        NSLog(@"price: %d amount %d ", price.intValue, amount.intValue);  //  [test] print 價格  購買數量
        NSLog(@"%@ ：NT$ %d 買%d個",[ thisObj objectAtIndex:0], price.intValue, amount.intValue);
        NSLog(@"NT$ %d",price.intValue * amount.intValue);
        totalCost += price.intValue * amount.intValue;
        eachCost = 0;
    }
        NSLog(@"算出三個商品的購買總價於此");
        NSLog(@"total Cost : NT$ %d ",totalCost);   //  total Cost : NT$ 289000
    
    NSLog(@"--------------End--------------");
}

@end
