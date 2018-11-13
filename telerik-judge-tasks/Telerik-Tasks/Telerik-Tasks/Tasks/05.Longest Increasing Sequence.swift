//
//  05.Longest Increasing Sequence.swift
//  Telerik-Tasks
//
//  Created by Plamen on 13.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation


/*
 Write a program that finds the length of the maximal increasing sequence in an array of N integers.
 
 Input
 Read from the standard input
 
 On the first line you will receive the number N
 On the next N lines the numbers of the array will be given
 
 Output
 Print to the standard output
 
 Print the length of the maximal increasing sequence
 */
class Task5 {
    func LongestIncreasingSequence() {
        let n = Int(readLine()!)!
        var previousNumber = Int(readLine()!)!
        var currentSequence = 1
        var maxSequence = 1
        
        for _ in 0..<n-1 {
            let nextNumber = Int(readLine()!)!
            
            if nextNumber > previousNumber {
                currentSequence += 1
                
                if currentSequence > maxSequence {
                    maxSequence = currentSequence
                }
            } else {
                currentSequence = 1
            }
            
            previousNumber = nextNumber
        }
        
        print(maxSequence)
    }
}
