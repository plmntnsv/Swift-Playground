//
//  ViewController.swift
//  Concetration
//
//  Created by Plamen on 5.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfParisOfCards: (cardButtons.count + 1) / 2)
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount+=1
        //let cardNumber = cardButtons.index(of: sender)!
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }  else {
            print("card was not in card buttons!")
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👽","🤟","🎃","👻","🧠","🐷","💪🏻","👀","🐸"]
    
    func emoji(for card: Card) -> String {
        return "?"
    }
}
