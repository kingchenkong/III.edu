//
//  ViewController.swift
//  hw_may_25
//
//  Created by 陳維漢 on 2016/5/24.
//  Copyright © 2016年 陳維漢. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var hwIndex=1
        func pr_hwIndex (index:Int) {
            print("This is \(index)_Hw")        //      print Hw index
            hwIndex+=1
        }
        func hr () {
            for _ in 0...10{
                print("----",terminator:"")       //      horizontal
            }
            print("\n")
        }
        //--------------主程式開始--------------
        hr()                    //          我是分隔線
        pr_hwIndex(hwIndex)     //   1_Hw_25_May     age 18~29,65~74
        
        for _ in 0...3
        {
            let urAge = arc4random()%120
            print("your Age is \(urAge)")
            
            switch urAge {
            case 18...29 :
                print("你可以參加 青年 就業讚！！！")
            case 65...74 :
                print("你可以參加 老頭 就業讚！！！")
            default:
                print("你無法參加補助方案 Ｔ＿Ｔ")
            }
        }
        hr()                    //          我是分隔線
        pr_hwIndex(hwIndex)     //   2_Hw_25_May     99乘法表
        
        for i in 1...9 {
            for j in 1...9 {
                print("\(j)x\(i)= \(i*j<10 ? " ":"")\(i*j)",terminator:"  ")
            }
            print()
        }
        hr()                    //          我是分隔線
        pr_hwIndex(hwIndex)     //   3_Hw_25_May     聖誕樹 (其實是金字塔吧！？
        
        let F = 17   //層數
        for i in 1.stride(to: 2*F, by: 2) {
            for _ in i.stride(to: 2*F, by: 2) {
                print(" ",terminator:"")            //顯白
            }
            for _ in 1.stride(to: 2*i, by: 2) {
                print("*",terminator:"")            //顯嘿
            }
            print()
        }
        
        hr()                    //          我是分隔線
        pr_hwIndex(hwIndex)     //   4_Hw_25_May     sum=5050
        var sum = 0
        for x in 1...100{
            sum += x
        }
        print(sum)
        hr()                    //          我是分隔線
        //  5_Hw_25_May     6~15,找出數列中  最小  且   又不是質數的整數
        pr_hwIndex(hwIndex)
        
        hw5外層迴圈:
            for i in 6...15 {
                if i%2==0 {print("\(i)是 數列中  最小  且   又不是質數的整數");break hw5外層迴圈}
                for j in 3.stride(to: (i-1), by: 2) {
                    //print("i=\(i),j=\(j)",terminator:"  ")
                    if i%j==0{
                        print("\(i)是 數列中  最小  且   又不是質數的整數")
                        break hw5外層迴圈
                    }
                }
        }
        hr()                    //          我是分隔線
        //          is Over
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

