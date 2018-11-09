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
    
    private(set) var activeCards = [Card]()
    
    private(set) var currentlySelectedCards = [Card]()
    private(set) var matchedCards = [Card]()
    
    init(numberOfCards: Int) {
        generateCards()
        activeCards.append(contentsOf: allCards.takeFromStart(numberOfElementsToTake: numberOfCards))
        allCards.removeFromStart(numberOfElementsToRemove: numberOfCards)
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

    mutating func replaceCards(indicesOfCardsToReplace array: [Int]) {
        for index in array {
            let newCard = allCards.removeFirst()
            activeCards.replace(newElement: newCard, at: index)
        }
    }
    
    mutating func addThreeMoreCards(){
        activeCards.append(contentsOf: allCards.takeFromStart(numberOfElementsToTake: 3))
        allCards.removeFromStart(numberOfElementsToRemove: 3)
    }
}

protocol SetGameProtocol {
    var allCards: [Card] {get}
    var gameCards: [Card] {get}
    var currentlySelectedCards: [Card] {get}
    var matchedCards: [Card] {get}
    
    mutating func selectCard(card: Card) -> Card
}

