//
//  Card.swift
//  Set
//
//  Created by Plamen on 7.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

struct Card : CustomStringConvertible
{
    var description: String {
        return "\(number) \(color) \(shape) \(fill)"
    }
    
    let number: SetNumber
    let color: SetColor
    let shape: SetShape
    let fill: SetFill
}

enum SetColor : CaseIterable {
    case Red, Green, Purple
}

enum SetNumber : CaseIterable {
    case One, Two, Three
}

enum SetShape : CaseIterable {
    case Oval, Diamond, Squiggle
}

enum SetFill : CaseIterable {
    case Solid, Striped, Open
}
