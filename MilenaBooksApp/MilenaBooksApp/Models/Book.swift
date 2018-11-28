//
//  Book.swift
//  MilenaBooksApp
//
//  Created by Plamen on 23.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation
import ObjectMapper

struct Book: Mappable {
    var id: Int?
    var title: String?
    var price: Double?
    var author: String?
    var rating: Int?
    var coverImageUrl: String?
    var description: String?
    var coverImage: Data?
    
    init(id: Int?, title: String?, price: Double?, author: String?, rating: Int?, coverImageUrl: String?, description: String?){
        self.id = id
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
        id <- map["Id"]
        title <- map["Name"]
        price <- map["Price"]
        author <- map["Author"]
        rating <- map["Rating"]
        coverImageUrl <- map["PictureURL"]
        description <- map["Description"]
    }
}
