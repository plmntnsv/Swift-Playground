//
//  06.Max Sum of Subsequence.swift
//  Telerik-Tasks
//
//  Created by Plamen on 15.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

/*
 Write a program that finds the maximal sum of consecutive elements in a given array of N numbers.
 
 _Can you do it with only one loop (with single scan through the elements of the array)?_
 Input
 On the first line you will receive the number N
 On the next N lines the numbers of the array will be given
 Output
 Print the maximal sum of consecutive numbers
 Constraints
 1 <= N <= 1024
 */
class Task6 {
    func MaxSumOfSeq() {
        let n = Int(readLine()!)!
        var sum = 0
        var maxSum = 0
        
        for _ in 0..<n {
            let number = Int(readLine()!)!
            sum += number
            
            if sum > maxSum {
                maxSum = sum
            }
            
            if number > sum {
                sum = number
            }
        }
        
        print(maxSum)
    }
}
