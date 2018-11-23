//
//  Book.swift
//  MilenaBooksApp
//
//  Created by Plamen on 23.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

class Book {
    let id: Int = 0
    let title: String
    let price: Double
    let author: String
    let rating: Int
    let coverImageUrl: String?
    
    init?(name: String, price: Double, author: String, rating: Int, coverImageUrl: String?) {
        
        if name.isEmpty || price < 0 || author.isEmpty || rating < 0 {
            return nil
        }
        
        self.title = name
        self.price = price
        self.author = author
        self.rating = rating
        self.coverImageUrl = coverImageUrl
    }
}
