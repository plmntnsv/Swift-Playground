//
//  ImgurCoverImage.swift
//  MilenaBooksApp
//
//  Created by Plamen on 6.12.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation
import ObjectMapper

class ImgurCoverImage: Mappable {
    var id: String?
    var link: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        link <- map["link"]
    }
}
