//
//  08.Larges Area in Matrix.swift
//  Telerik-Tasks
//
//  Created by Plamen on 22.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation
/*
 Write a program that finds the largest area of equal neighbour elements in a rectangular matrix and prints its size.
 
 Input
 On the first line you will receive the numbers N and M separated by a single space
 On the next N lines there will be M numbers separated with spaces - the elements of the matrix
 Output
 Print the size of the largest area of equal neighbour elements
 Constraints
 3 <= N, M <= 1024
 Time limit: 0.35s
 Memory limit: 24MB
*/
class Task8 {
    func largestAreaInMatrix(){
        let nm = readLine()!.split(separator: " ")
        let n = Int(nm[0])!
        let m = Int(nm[1])!
        
        var arr = [[Int]]()
        
        for _ in 0..<n {
            let numbers = readLine()!.split(separator: " ").map { Int($0)! }
            arr.append(numbers)
        }
        
    }
}
