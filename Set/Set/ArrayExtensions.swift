//
//  ArrayExtensions.swift
//  Set
//
//  Created by Plamen on 9.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

extension Array {
    mutating func takeFromStart(numberOfElementsToTake: Int) -> [Element] {
        let end = numberOfElementsToTake <= self.count ? numberOfElementsToTake : self.count
        var result = [Element]()
        for index in stride(from: 0, to: end, by: 1){
            result.append(self[index])
        }
        
        return result
    }
    
    mutating func removeFromStart(numberOfElementsToRemove: Int) {
        let end = numberOfElementsToRemove <= self.count ? numberOfElementsToRemove : self.count
        for _ in stride(from: 0, to: end, by: 1){
            self.removeFirst()
        }
    }
    
    mutating func replace(newElement element: Element, at index: Int) {
        self.remove(at: index)
        let end = index+1 > self.count ? index : index+1
        self.insert(element, at: end)
    }
}
