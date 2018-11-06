//
//  Card.swift
//  Concetration
//
//  Created by Plamen on 5.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

struct Card{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    private static var identifierFactory = 0
    
    init() {
        self.identifier = Card.getUniqieIdentifier()
    }
    
    private static func getUniqieIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
}
