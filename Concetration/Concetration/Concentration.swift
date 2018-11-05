//
//  Concentration.swift
//  Concetration
//
//  Created by Plamen on 5.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    init(numberOfParisOfCards: Int){
        for _ in 1...numberOfParisOfCards{
            let card = Card()
            cards += [card,card]
        }
    }
    // TODO: Shuffle the cards
    func chooseCard(at index:Int){
        
    }
}
