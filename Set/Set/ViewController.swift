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
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var dealCardsBtn: UIButton!
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBAction func selectCard(_ sender: UIButton) {
        if sender.layer.borderWidth == 0 {
            sender.layer.borderWidth = 3.0
            sender.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        } else {
            sender.layer.borderWidth = 0
            sender.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
        }
        
    }
    
    @IBAction func dealThreeMoreCardsClicked(_ sender: UIButton) {
    }
    
    @IBAction func newGameClicked(_ sender: UIButton) {
    }
}
