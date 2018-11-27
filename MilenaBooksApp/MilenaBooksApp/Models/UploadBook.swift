//
//  UploadBook.swift
//  MilenaBooksApp
//
//  Created by Plamen on 27.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

struct UploadBook {
    let title: String?
    let price: Double
    let author: String
    let rating: Int
    let coverImageUrl: String?
    let description: String?
    
    init(title: String, price: Double, author: String, rating: Int, coverImageUrl: String?, description: String?){
        // TODO: validate
        self.title = title
        self.price = price
        self.author = author
        self.rating = rating
        self.coverImageUrl = coverImageUrl
        self.description = description
    }
}
