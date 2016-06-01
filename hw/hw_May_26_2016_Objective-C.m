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
        pr_hwIndex();               //   1_Hw_26_May     age 18~29,65~74
        
        int i = 1 ;
        for(i=0;i<=5;i+=1){
            int randage = arc4random()%70 + 10;
            printf("u r %d years old.",randage);
            if((randage>18)&&(randage<24)){
                printf("%s","你可以參加 青年 就業讚！！\n");}
            else if((randage>65)&&(randage<74)){
                printf("%s","你可以參加 老年 就業讚！！\n");}
            else{
                printf("%s","你無法參加補助方案 Ｔ＿Ｔ\n");
            }
        }
        //###########################I m code cannot ###################################
        hr();                       //          我是分隔線
        pr_hwIndex();               //   2_Hw_26_May     九九乘法表
        
        int j = 1;
        for(i=1;i<=9;i+=1){
            for(j=1;j<=9;j+=1){
                printf("%dx%d=%s%d ",j,i,((i*j<10) ? " ":""),i*j);
            }
            printf("\n");
        }
        //###########################I m code cannot ###################################
        hr();                       //          我是分隔線
        pr_hwIndex();               //   3_Hw_26_May     聖誕樹 (其實是金字塔吧！？
        int F = 15;   //層數
        int k = 1;
        for (i=1;i<=2*F;i+=2){
            for (j=i;j<2*F-1;j+=2) {
                printf("%s"," ");            //顯白
            }
            j=i;
            for (k=1;k<2*j;k+=2) {
                printf("%s","*");            //顯嘿
            }
            printf("\n");
        }
        //###########################I m code cannot ###################################
        hr();                       //          我是分隔線
        pr_hwIndex();               //   4_Hw_26_May          sum=5050
        int x,sum = 0;
        for (x=1;x<=100;x+=1){
            sum += x;
        }
        printf("1+2+3+...+100 = %d \n",sum);
        //###########################I m code cannot ###################################
        hr();                       //          我是分隔線
        pr_hwIndex();               //   5_Hw_26_May          6~15,找出數列中  最小  且   又不是質數的整數
        
        
        for (i=6;i<=15;i+=1) {
            if (i>2){
                if (i%2==0) {printf("%d 是 數列中  最小  且   又不是質數的整數\n",i); goto hw5外層迴圈;}
                for (j=3;j<i-1;j+=2) {
                    printf("i=%d,j=%d \n",i,j);
                    if (i%j==0) {
                        printf("%d 是 數列中  最小  且   又不是質數的整數\n",i);
                        goto hw5外層迴圈;
                    }
                }
            }
        }
    }
    hw5外層迴圈:
    hr();                    //          我是分隔線
    //          is Over
    return 0;
}


