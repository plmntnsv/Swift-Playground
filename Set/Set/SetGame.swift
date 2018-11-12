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
    private(set) var matchedCards = [Card]()
    var currentlySelectedCards = [Card]()
    private(set) var points = 0
    private var removedPointsForDifficulty = 0
    
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
        
        allCards.shuffle()
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
        removedPointsForDifficulty += 1
    }
    
    mutating func selectCard(indexOfCard: Int){
        currentlySelectedCards.append(activeCards[indexOfCard])
    }
    
    mutating func deselectCard(indexOfCard: Int) {
        currentlySelectedCards.remove(at: indexOfCard)
    }
    
    mutating func deselectAllCards(){
        currentlySelectedCards.removeAll()
    }
    
    mutating func scoreGame() {
        if checkIfItIsASet() {
            points += (5-removedPointsForDifficulty)
            
        } else {
            points -= 2
        }
    }
    
    func checkIfItIsASet() -> Bool {
        var isMatch = false
        if currentlySelectedCards.count == 3 {
            let cardOne = currentlySelectedCards[0]
            let cardTwo = currentlySelectedCards[1]
            let cardThree = currentlySelectedCards[2]
            
            isMatch = checkNumbers(of: cardOne, of: cardTwo, of: cardThree)
            
            if !isMatch {
                return false
            }
            
            isMatch = checkShapes(of: cardOne, of: cardTwo, of: cardThree)
            
            if !isMatch {
                return false
            }
            
            isMatch = checkColors(of: cardOne, of: cardTwo, of: cardThree)
            
            if !isMatch {
                return false
            }
            
            isMatch = checkFills(of: cardOne, of: cardTwo, of: cardThree)
        }
        
        return isMatch
    }
    
    private func checkNumbers(of cardOne: Card, of cardTwo: Card, of cardThree: Card) -> Bool {
        if cardOne.number == cardTwo.number && cardTwo.number == cardThree.number {
            return true
        }
        
        if cardOne.number != cardTwo.number &&
            cardOne.number != cardThree.number &&
            cardTwo.number != cardThree.number {
            return true
        }
        
        return false
    }
    
    private func checkShapes(of cardOne: Card, of cardTwo: Card, of cardThree: Card) -> Bool {
        if cardOne.shape == cardTwo.shape && cardTwo.shape == cardThree.shape {
            return true
        }
        
        if cardOne.shape != cardTwo.shape &&
            cardOne.shape != cardThree.shape &&
            cardTwo.shape != cardThree.shape {
            return true
        }
        
        return false
    }
    
    private func checkColors(of cardOne: Card, of cardTwo: Card, of cardThree: Card) -> Bool {
        if cardOne.color == cardTwo.color && cardTwo.color == cardThree.color {
            return true
        }
        
        if cardOne.color != cardTwo.color &&
            cardOne.color != cardThree.color &&
            cardTwo.color != cardThree.color {
            return true
        }
        
        return false
    }
    
    private func checkFills(of cardOne: Card, of cardTwo: Card, of cardThree: Card) -> Bool {
        if cardOne.fill == cardTwo.fill && cardTwo.fill == cardThree.fill {
            return true
        }
        
        if cardOne.fill != cardTwo.fill &&
            cardOne.fill != cardThree.fill &&
            cardTwo.fill != cardThree.fill {
            return true
        }
        
        return false
    }
}

//protocol SetGameProtocol {
//    var allCards: [Card] {get}
//    var gameCards: [Card] {get}
//    var currentlySelectedCards: [Card] {get}
//    var matchedCards: [Card] {get}
//
//    mutating func selectCard(card: Card) -> Card
//}

