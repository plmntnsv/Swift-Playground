//
//  03.Max Sum of K elements.swift
//  TelerikJudgeTasks
//
//  Created by Plamen on 5.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

class Task3
{
    // Write a program that reads two integer numbers N and K and an array of N elements from the console.
    // Find the maximal sum of K elements in the array.
    func MaxSumOfKElements() {
        let n = Int(readLine()!)!
        let k = Int(readLine()!)!
        var array = [Int]()
        
        for _ in 0..<n{
            array.append(Int(readLine()!)!)
        }
        
        array.sort()
        array.reverse()
        
        var max = 0;
        for i in 0..<k{
            max += array[i]
        }
        
        print(max)
    }
}
