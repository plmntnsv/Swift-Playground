//
//  BookMockData.swift
//  MilenaBooksApp
//
//  Created by Plamen on 23.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

struct BookMockData {
    static let responseBooks: [Book] =
        [
        Book(id: 1,
             title: "Test TESTTTTT TESTTTTT Test TESTTTTT TESTTTTT Test TESTTTTT TESTTTTT asdadadasdasda 123",
             price: 1.2,
             author: "Author zzzzzzzzzzzzssssasdasd Author zzzzzzzzzzzzssssasdasd Author zzzzzzzzzzzzssssasdasd Author zzzzzzzzzzzzssssasdasd 123",
             rating: 3,
             coverImageUrl: "https://about.canva.com/wp-content/uploads/sites/3/2015/01/children_bookcover.png"),
        Book(id: 2,
             title: "Test Title 2",
             price: 3.4,
             author: "Test Author With Long Name Test Author With Long Name Test Author With Long Name Test Author With Long Name Test Author With Long Name Test Author With Long Name",
             rating: 5,
             coverImageUrl: "https://about.canva.com/wp-content/uploads/sites/3/2015/01/art_bookcover.png"),
        Book(id: 3,
             title: "Test Title 3",
             price: 3.4,
             author: "Test Author 3",
             rating: 5,
             coverImageUrl: "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/book-cover-flyer-template-6bd8f9188465e443a5e161a7d0b3cf33.jpg?ts=1456287935")
    ]
    
    private static let title = "The Art of Unit Testing"
    private static let price = 100.0
    private static let rating = 5
    private static let author = "Roy Osherove"
    private static let coverUrl = "http://t1.gstatic.com/images?q=tbn:ANd9GcRll7vIIAPsaPfALjtDK-jVGFa2KZ4ZRsccYeBm2viTHQ-e_VNr"
    private static let description = "The Art of Unit Testing is a 2009 book by Roy Osherove which covers unit test writing for software. It's written with .NET Framework examples, but the fundamentals can be applied by any developer. The second edition was published in 2013."
    
    static let uploadBook = UploadBook(title: title, price: price, author: author, rating: rating, coverImageUrl: coverUrl, description: description)
}
