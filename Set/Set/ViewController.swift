//
//  ViewController.swift
//  Set
//
//  Created by Plamen on 7.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy private(set) var game = SetGame(numberOfCards: activeCardButtons.count)
    
    private var currentlySelectedCardButtons = [UIButton]()
    let maxActiveCards = 24
    
    @IBOutlet var activeCardButtons: [UIButton]!
    @IBOutlet var inactiveCardButtons: [UIButton]!
    
    @IBOutlet weak var dealCardsBtn: UIButton!
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBAction func selectCard(_ sender: UIButton) {
        
        if currentlySelectedCardButtons.count < 3 {
            if sender.layer.borderWidth == 0 {
                select(sender)
            } else {
                deselect(sender)
            }
        } else {
            deselectAll()
            select(sender)
        }
    }
    
    @IBAction func dealThreeMoreCardsClicked(_ sender: UIButton) {
        dealThreeMoreCards()
    }
    
    private func dealThreeMoreCards() {
        
        if activeCardButtons.count < maxActiveCards {
            if currentlySelectedCardButtons.count == 3 {
                // TODO: check if they are a match, if they are, do:
                var indices = [Int]()
                for index in currentlySelectedCardButtons.indices {
                    indices.append(activeCardButtons.firstIndex(of: currentlySelectedCardButtons[index])!)
                }
//                for index in game.activeCards.indices {
//                    print("\(index) \(game.activeCards[index])")
//                }
//                print("---")
                game.replaceCards(indicesOfCardsToReplace: indices)
//                currentlySelectedCardButtons.forEach {
//                    let cardBtn = inactiveCardButtons.removeFirst()
//                    activeCardButtons.replace(newElement: cardBtn, at: activeCardButtons.firstIndex(of: $0)!)
//                }
            } else {
                let newActiveButtons = inactiveCardButtons.takeFromStart(numberOfElementsToTake: 3)
                inactiveCardButtons.removeFromStart(numberOfElementsToRemove: 3)
                newActiveButtons.forEach { $0.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0); $0.isEnabled = true }
                
                activeCardButtons.append(contentsOf: newActiveButtons)
                game.addThreeMoreCards()
            }
            
            drawCards()
        }
        
        if (activeCardButtons.count == maxActiveCards) {
            dealCardsBtn.isEnabled = false
            dealCardsBtn.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        }
    }
    
    @IBAction func newGameClicked(_ sender: UIButton) {
        dealCardsBtn.isEnabled = true
        dealCardsBtn.backgroundColor = #colorLiteral(red: 0, green: 0.9801092744, blue: 0.5720278621, alpha: 1)
        drawCards()
    }
    
    private func drawCards() {
        for index in activeCardButtons.indices{
            activeCardButtons[index].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            activeCardButtons[index].setTitle(game.activeCards[index].description, for: UIControl.State.normal)
        }
    }
    
    private func select(_ btn: UIButton){
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        currentlySelectedCardButtons.append(btn)
        game.selectCard(indexOfCard: activeCardButtons.firstIndex(of: btn)!)
    }
    
    private func selectMatch(_ btn: UIButton){
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    }
    
    private func selectMissmatch(_ btn: UIButton){
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
    }
    
    private func deselect(_ btn: UIButton) {
        btn.layer.borderWidth = 0
        btn.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
        game.deselectCard(indexOfCard: currentlySelectedCardButtons.firstIndex(of: btn)!)
        
        currentlySelectedCardButtons.remove(at: currentlySelectedCardButtons.firstIndex(of: btn)!)
    }
    
    private func deselectAll(){
        currentlySelectedCardButtons.forEach() { deselect($0) }
        currentlySelectedCardButtons.removeAll()
        //game.deselectAllCards()
    }
}
