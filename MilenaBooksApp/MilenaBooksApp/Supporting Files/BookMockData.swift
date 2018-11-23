//
//  BookMockData.swift
//  MilenaBooksApp
//
//  Created by Plamen on 23.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

struct BookMockData {
    static var books = [
        Book(name: "Test TESTTTTT TESTTTTT Test TESTTTTT TESTTTTT Test TESTTTTT TESTTTTT asdadadasdasda 123",
             price: 1.2,
             author: "Author zzzzzzzzzzzzssssasdasd Author zzzzzzzzzzzzssssasdasd Author zzzzzzzzzzzzssssasdasd Author zzzzzzzzzzzzssssasdasd 123",
             rating: 3,
             coverImageUrl: "https://about.canva.com/wp-content/uploads/sites/3/2015/01/children_bookcover.png"),
        Book(name: "Test Title 2",
             price: 3.4,
             author: "Test Author With Long Name Test Author With Long Name Test Author With Long Name Test Author With Long Name Test Author With Long Name Test Author With Long Name",
             rating: 5,
             coverImageUrl: "https://about.canva.com/wp-content/uploads/sites/3/2015/01/art_bookcover.png"),
        Book(name: "Test Title 3",
             price: 3.4,
             author: "Test Author 3",
             rating: 5,
             coverImageUrl: "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/book-cover-flyer-template-6bd8f9188465e443a5e161a7d0b3cf33.jpg?ts=1456287935")
    ]
}
