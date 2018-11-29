//
//  BookEndPoint.swift
//  MilenaBooksApp
//
//  Created by Plamen on 29.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation

struct ApiEndPoints {
    private static let url = "http://milenabooks.azurewebsites.net/api"
    
    enum EndPoint: String {
        case books = "/books"
        case account = "/account"
        case store = "/store"
        case upload = "/upload"
    }
    
    enum BookEndPoint {
        case getAll
        case get(book: Book)
        case post
        case edit(book: Book)
        case delete(book: Book)
        
        var fullUrl: String {
            switch self {
            case .getAll:
                return "\(url)\(EndPoint.books.rawValue)"
            case .get(let book):
                return "\(url)\(EndPoint.books.rawValue)/\(book.id!)"
            case .post:
                return "\(url)\(EndPoint.books.rawValue)/"
            case .edit(let book):
                return "\(url)\(EndPoint.books.rawValue)/\(book.id!)"
            case .delete(let book):
                return "\(url)\(EndPoint.books.rawValue)/\(book.id!)"
            }
        }
    }
}
