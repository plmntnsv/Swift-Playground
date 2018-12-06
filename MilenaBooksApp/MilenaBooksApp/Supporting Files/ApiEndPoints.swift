//
//  BookEndPoint.swift
//  MilenaBooksApp
//
//  Created by Plamen on 29.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

struct ApiEndPoints {
    private static let milenBooksBaseURL = "http://milenabooks.azurewebsites.net/api"
    private static let imgurBaseURL = "https://api.imgur.com/3"
    private static let imgurAccessToken = "4becd99646668cba54a50dd249ff6304e7a2440b"
    
    private enum EndPoint: String {
        case books = "/books"
        case image = "/image"
    }
    
    enum Books {
        case getAll
        case get(book: Book)
        case post
        case edit(book: Book)
        case delete(book: Book)
        case postBookCover
        
        var fullUrl: String {
            switch self {
            case .getAll:
                return "\(milenBooksBaseURL)\(EndPoint.books.rawValue)"
            case .get(let book):
                return "\(milenBooksBaseURL)\(EndPoint.books.rawValue)/\(book.id!)"
            case .post:
                return "\(milenBooksBaseURL)\(EndPoint.books.rawValue)/"
            case .edit(let book):
                return "\(milenBooksBaseURL)\(EndPoint.books.rawValue)/\(book.id!)"
            case .delete(let book):
                return "\(milenBooksBaseURL)\(EndPoint.books.rawValue)/\(book.id!)"
            case .postBookCover:
                return "\(imgurBaseURL)\(EndPoint.image.rawValue)"
            }
            
        }
    }
}
