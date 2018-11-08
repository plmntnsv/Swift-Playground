//
//  Card.swift
//  Concetration
//
//  Created by Plamen on 5.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

struct Card : Hashable
{
    var isFaceUp = false
    var isMatched = false
    var isSeen = false
    private var identifier: Int
    private static var identifierFactory = 0
    var hashValue: Int { return identifier}
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init() {
        self.identifier = Card.getUniqieIdentifier()
    }
    
    private static func getUniqieIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
}
