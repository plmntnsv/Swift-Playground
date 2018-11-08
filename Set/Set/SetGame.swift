//
//  SetGame.swift
//  Set
//
//  Created by Plamen on 7.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

struct SetGame
{
    
    private(set) var allCards = [Card]()
    private(set) var gameCards = [Card]()
    private(set) var currentlySelectedCards = [Card]()
    private(set) var matchedCards = [Card]()
    
    init() {
        generateCards()
    }
    
    mutating private func generateCards(){
        for number in SetNumber.allCases {
            for shape in SetShape.allCases {
                for color in SetColor.allCases {
                    for fill in SetFill.allCases {
                        allCards.append(Card(number: number, color: color, shape: shape, fill: fill))
                    }
                }
            }
        }
    }
    
}

protocol SetGameProtocol {
    var allCards: [Card] {get}
    var gameCards: [Card] {get}
    var currentlySelectedCards: [Card] {get}
    var matchedCards: [Card] {get}
    
    mutating func selectCard(card: Card) -> Card
}

