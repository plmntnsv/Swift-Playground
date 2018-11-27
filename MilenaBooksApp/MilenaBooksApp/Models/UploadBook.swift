//
//  UploadBook.swift
//  MilenaBooksApp
//
//  Created by Plamen on 27.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation
import ObjectMapper

struct UploadBook: Mappable {
    var title: String?
    var price: Double?
    var author: String?
    var rating: Int?
    var coverImageUrl: String?
    var description: String?
    
    init(title: String, price: Double, author: String, rating: Int, coverImageUrl: String?, description: String?){
        // TODO: validate
        self.title = title
        self.price = price
        self.author = author
        self.rating = rating
        self.coverImageUrl = coverImageUrl
        self.description = description
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["Name"]
        price <- map["Price"]
        author <- map["Author"]
        rating <- map["Rating"]
        coverImageUrl <- map["PictureURL"]
        description <- map["Description"]
    }
}
