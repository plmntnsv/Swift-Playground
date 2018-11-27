//
//  Book.swift
//  MilenaBooksApp
//
//  Created by Plamen on 23.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation
import ObjectMapper

class Book: Mappable {
    var id: Int?
    var title: String?
    var price: Double?
    var author: String?
    var rating: Int?
    var coverImageUrl: String?
    var description: String?
    var coverImage: Data?
    
    init(id: Int, title: String, price: Double, author: String, rating: Int, coverImageUrl: String){
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["Id"]
        title <- map["Name"]
        price <- map["Price"]
        author <- map["Author"]
        rating <- map["Rating"]
        coverImageUrl <- map["PictureURL"]
        description <- map["Description"]
    }
}
