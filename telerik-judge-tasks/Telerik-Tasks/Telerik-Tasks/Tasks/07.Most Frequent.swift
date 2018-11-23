//
//  07.Most Frequent.swift
//  Telerik-Tasks
//
//  Created by Plamen on 15.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation
/*
 Write a program that finds the most frequent number in an array of N elements.
 
 Input
 On the first line you will receive the number N
 On the next N lines the numbers of the array will be given
 Output
 Print the most frequent number and how many time it is repeated
 Output should be REPEATING_NUMBER (REPEATED_TIMES times)
 Constraints
 1 <= N <= 1024
 0 <= each number in the array <= 10000
 There will be only one most frequent number
 */
class Task7 {
    func mostFrequent(){
        let n = Int(readLine()!)!
        var numbers = [Int:Int]()
        
        for _ in 0..<n {
            let number = Int(readLine()!)!

            if !numbers.keys.contains(number) {
                numbers[number] = 1
            } else {
                numbers[number] = numbers[number]! + 1
            }
        }
        let max = numbers.max { a, b in a.value < b.value }
        print("\(max!.key)(\(max!.value) times)")
    }
}
