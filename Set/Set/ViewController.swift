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
            replaceCardsOfSet()
            select(sender)
        }
        
        if currentlySelectedCardButtons.count == 3 {
            if game.checkIfItIsASet() {
                currentlySelectedCardButtons.forEach {
                    selectMatch($0)
                }
            } else {
                currentlySelectedCardButtons.forEach {
                    selectMissmatch($0)
                }
            }
        }
    }
    
    @IBAction func dealThreeMoreCardsClicked(_ sender: UIButton) {
        if activeCardButtons.count < maxActiveCards || game.allCards.any {
            if currentlySelectedCardButtons.count == 3 {
                replaceCardsOfSet()
            } else {
                let newActiveButtons = inactiveCardButtons.takeFromStart(numberOfElementsToTake: 3)
                inactiveCardButtons.removeFromStart(numberOfElementsToRemove: 3)
                newActiveButtons.forEach { $0.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0); $0.isEnabled = true }
                
                activeCardButtons.append(contentsOf: newActiveButtons)
                game.addThreeMoreCards()
            }
            
            drawCards()
        }
        
        if activeCardButtons.count == maxActiveCards || !game.allCards.any {
            dealCardsBtn.isEnabled = false
            dealCardsBtn.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
            dealCardsBtn.setTitle("Max cards displayed", for: UIControl.State.disabled)
        }
    }
    
    private func replaceCardsOfSet() {
        if game.checkIfItIsASet() {
            var indices = [Int]()
            for index in currentlySelectedCardButtons.indices {
                indices.append(activeCardButtons.firstIndex(of: currentlySelectedCardButtons[index])!)
            }
            
            if game.allCards.any {
                game.replaceCards(indicesOfCardsToReplace: indices)
                drawCards()
            } else {
                currentlySelectedCardButtons.forEach {
                    $0.isEnabled = false
                    $0.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                    $0.setAttributedTitle(NSAttributedString(string: " "), for: UIControl.State.disabled)
                }
                
                dealCardsBtn.isEnabled = false
                dealCardsBtn.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                dealCardsBtn.setTitle("No more cards", for: UIControl.State.disabled)
            }
        }
        
        deselectAll()
    }
    
    @IBAction func newGameClicked(_ sender: UIButton) {
        // TODO: other start up game stuff
        dealCardsBtn.isEnabled = true
        dealCardsBtn.backgroundColor = #colorLiteral(red: 0, green: 0.9801092744, blue: 0.5720278621, alpha: 1)
        drawCards()
    }
    
    private func drawCards() {
        for index in activeCardButtons.indices{
            activeCardButtons[index].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            let card = game.activeCards[index]
            
            var attributes: [NSAttributedString.Key: Any] = [
                .font : UIFont.systemFont(ofSize: 25)
            ]
            
            var shape: String
            var text: String
            
            switch card.color {
            case .Red:
                attributes[.foregroundColor] = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            case .Green:
                attributes[.foregroundColor] = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            case .Purple:
                attributes[.foregroundColor] = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            }
            
            switch card.shape {
            case .Oval:
                shape = "▲"
            case .Diamond:
                shape = "●"
            case .Squiggle:
                shape = "■"
            }
            
            switch card.number {
            case .One:
                text = shape
            case .Two:
                text = "\(shape) \(shape)"
            case .Three:
                text = "\(shape) \(shape) \(shape)"
            }
            
            switch card.fill {
            
            case .Solid:
                attributes[.strokeWidth] = -4
            case .Striped:
                let col = attributes[.foregroundColor] as! UIColor
                attributes[.foregroundColor] = col.withAlphaComponent(0.5)
            case .Open:
                attributes[.strokeWidth] = 4
            }
            
            let attributedString = NSAttributedString(string: text, attributes: attributes)
            activeCardButtons[index].setAttributedTitle(attributedString, for: UIControl.State.normal)
        }
    }
    
    private func select(_ btn: UIButton){
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        currentlySelectedCardButtons.append(btn)
        game.selectCard(indexOfCard: activeCardButtons.firstIndex(of: btn)!)
    }
    
    private func selectMatch(_ btn: UIButton){
        btn.layer.borderColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    }
    
    private func selectMissmatch(_ btn: UIButton){
        btn.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
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
    }
}
