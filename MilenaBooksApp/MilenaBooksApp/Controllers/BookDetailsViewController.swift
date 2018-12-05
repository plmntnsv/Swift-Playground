//
//  BookDetailsViewController.swift
//  MilenaBooksApp
//
//  Created by Plamen on 26.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class BookDetailsViewController: UIViewController {
    private lazy var url = ApiEndPoints.Books.get(book: book!).fullUrl
    var book: Book?
    var isEditted = false
    private var deleteBook = false
    private let webClient = WebClient()
    
    @IBOutlet weak var bookDetailsView: BookDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayBookDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            if let navController = self.navigationController, let allBooksVC = navController.viewControllers[0] as? AllBooksTableViewController {
                allBooksVC.newBook = self.book
                allBooksVC.isAnEdit = isEditted
            }
        }
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        if let activityButton = sender as? ActivityButtonView {
            activityButton.showLoading()
            delete(url: ApiEndPoints.Books.delete(book: book!).fullUrl, sender: activityButton)
        }
    }
    
    private func displayBookDetails() {
        self.bookDetailsView.titleLabel.text = book?.title ?? "No title."
        self.bookDetailsView.authorNameLabel.text = book?.author ?? "No author."
        self.bookDetailsView.priceLabel.text = "Price: $\(Double((book?.price ?? 0.0)!))"
        self.bookDetailsView.ratingLabel.text = "Rating: \(Int((book?.rating ?? 0)!))"
        
        if let desc = book?.description {
            self.bookDetailsView.descriptionTextView.text = desc.isEmpty ? "No Description." : desc
        } else {
            get(from: url)
        }
        
        if let coverImage = self.book?.coverImage {
            self.bookDetailsView.bookCoverImageView.image = UIImage(data: Data(coverImage))
        } else {
            if let url = self.book?.coverImageUrl {
                self.bookDetailsView.bookCoverImageView.downloadImageFromUrl(urlString: url) { data in
                    self.bookDetailsView.bookCoverImageView.image = UIImage(data: data!)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsToEditUploadSegue" {
            if let destination = segue.destination as? UploadBookViewController {
                destination.book = book
            }
        }
    }
}

// API calls
extension BookDetailsViewController {
    private func get(from bookUrl: String) {
        webClient.getBook(url: bookUrl) { book in
            self.book?.description = book?.description
            self.displayBookDetails()
        }
    }
    
    private func delete(url: String, sender: ActivityButtonView) {
        webClient.deleteBook(url: url) { error in
            sender.hideLoading()
            
            if let error = error {
                print(error)
            }
            else if let navController = self.navigationController {
                self.isEditted = false
                if let allBooksVC = navController.viewControllers[0] as? AllBooksTableViewController {
                    allBooksVC.deleteBook = true
                }
                
                navController.viewControllers.removeLast()
            }
        }
    }
}
