//
//  main.m
//  May_26_Hw_Objective-C
//
//  Created by 陳維漢 on 2016/5/26.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

#import <Foundation/Foundation.h>

void hr() {
    int j = 0 ;
    for(j=0;j<=10;j+=1){
        printf("----");       //      horizontal
    }
    printf("\n");
}
int hwIndex = 1;
void pr_hwIndex() {
    printf("This is %d_Hw \n",hwIndex);        //      print Hw index
    hwIndex += 1;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // insert code here...
        printf("May_26_Hw_Objective-C Created by 陳維漢 on 2016/5/26.  \n");
        hr();                       //          我是分隔線
        pr_hwIndex();               //   1_Hw_27_May
        
        int testValue,runningdiv,divCount = 0;
        int rngMin = 1;
        int rngMax = 15;
        
        printf("%d ~ %d間的質數有: %s ",rngMin,rngMax,rngMin<3 ? "2":"");
        for (testValue=rngMin;testValue<=rngMax;testValue+=1) {
            if (testValue>2){
                if (testValue%2==1) {
                    for (runningdiv=3;runningdiv<testValue;runningdiv+=2) {
                        if (testValue%runningdiv==0) {
                            divCount+=1;
                        }
                    }
                    if (divCount<1){
                        printf("%d ",testValue);
                    }
                    divCount = 0;
                }
            }
        }
        printf("\n");
        
        
        
        //###########################I m code cannot ###################################
        hr();                       //          我是分隔線
        pr_hwIndex();               //   2_Hw_27_May
        
        
        //###########################I m code cannot ###################################
        hr();                       //          我是分隔線
        pr_hwIndex();               //   3_Hw_27_May
        
        //###########################I m code cannot ###################################
        hr();                       //          我是分隔線
        pr_hwIndex();               //   4_Hw_27_May          sum=5050
        
        //###########################I m code cannot ###################################
        hr();                       //          我是分隔線
        pr_hwIndex();               //   5_Hw_27_May
        
        hr();                    //          我是分隔線
        //          is Over
    }
    return 0;
}


