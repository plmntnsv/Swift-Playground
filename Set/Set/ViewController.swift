//
//  ViewController.swift
//  Set
//
//  Created by Plamen on 7.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private(set) var game = SetGame()
    
    private var currentlySelectedCardButtons = [UIButton]()
    
    @IBOutlet var activeCardButtons: [UIButton]!
    @IBOutlet var inactiveCardButtons: [UIButton]!
    
    @IBOutlet weak var dealCardsBtn: UIButton!
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBAction func selectCard(_ sender: UIButton) {
        
        if currentlySelectedCardButtons.count < 3 {
            if sender.layer.borderWidth == 0 {
                select(sender)
                currentlySelectedCardButtons.append(sender)
            } else {
                deselect(sender)
                currentlySelectedCardButtons.remove(at: currentlySelectedCardButtons.firstIndex(of: sender)!)
            }
        } else {
            currentlySelectedCardButtons.forEach() { $0.layer.borderWidth = 0; $0.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0) }
            currentlySelectedCardButtons.removeAll()
            select(sender)
            currentlySelectedCardButtons.append(sender)
        }
    }
    
    @IBAction func dealThreeMoreCardsClicked(_ sender: UIButton) {
        // TODO: impl deal tree more cards func
        if currentlySelectedCardButtons.count == 3 {
            // TODO: check if they are a match
            currentlySelectedCardButtons.forEach {
                let card = inactiveCardButtons.removeFirst()
                activeCardButtons.replace(element: card, at: activeCardButtons.firstIndex(of: $0)!)
            }
        }
        
    }
    
    @IBAction func newGameClicked(_ sender: UIButton) {
        // TODO: impl new game func
    }
    
    private func select(_ btn: UIButton){
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    
    private func deselect(_ btn: UIButton) {
        btn.layer.borderWidth = 0
        btn.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
    }
}

extension Array {
    mutating func replace(element: Element, at index: Int) {
        self.remove(at: index)
        self.insert(element, at: index+1)
    }
}
