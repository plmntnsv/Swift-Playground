//
//  ViewController.swift
//  Concetration
//
//  Created by Plamen on 5.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfParisOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
            return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        //let cardNumber = cardButtons.index(of: sender)!
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }  else {
            print("card was not in card buttons!")
        }
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        game = Concentration(numberOfParisOfCards: numberOfPairOfCards)
        randomThemeIndex = emojiChoices.count.arc4random
        currentGameEmojies = emojiChoices[randomThemeIndex]
        emoji = [Int:String]()
        updateViewFromModel()
    }
    
    private func updateViewFromModel(){
        pointsLabel.text = "Points: \(game.points)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
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
    
    private lazy var randomThemeIndex = emojiChoices.count.arc4random
    private lazy var currentGameEmojies = emojiChoices[randomThemeIndex]
    
    private var emojiChoices = [["✌️","🤟","✋","👍","👌","👊","💪","🙏","🤝"],
                                ["🤡","🧛🏻‍♂️","🎃","👻","😈","👹","🧙‍♀️","💀","👽"],
                                ["🎅🏻","🎄","🎁","❄️","⛄️","🌨","🦌","🛷","☃️"],
                                ["😀","🤓","😎","😱","😯","😵","😐","🥴","🤬"],
                                ["🐭","🙊","🐷","🐮","🐘","🦢","🐕","🐑","🐸"],
                                ["🍏","🍑","🥓","🥐","🍩","🥦","🍌","🌭","🍔"]]
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = currentGameEmojies.remove(at: currentGameEmojies.count.arc4random)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
