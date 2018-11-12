//
//  04.Longest Sequence of Equal.swift
//  Set
//
//  Created by Plamen on 12.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

class Task
{
    // Write a program that finds the length of the maximal sequence of equal elements in an array of N integers.
    func LongestSequenceOfEquals() {
        let n = Int(readLine()!)!
        
        var number: Int?
        var maxSequence = 0
        var currentSequence = 0
        
        for _ in 0..<n {
            let currentNumber = Int(readLine()!)!
            
            number = number ?? currentNumber
            
            if currentNumber == number {
                currentSequence += 1
                
                if currentSequence > maxSequence {
                    maxSequence = currentSequence
                }
            } else {
                number = currentNumber
                currentSequence = 1
            }
        }
        
        print(maxSequence)
    }
}
