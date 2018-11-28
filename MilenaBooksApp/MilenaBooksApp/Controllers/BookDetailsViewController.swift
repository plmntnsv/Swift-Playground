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
    var book: Book?
    var bookId: Int?
    
    @IBOutlet weak var bookDetailsView: BookDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayBookDetails()
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        
    }
    
    private func displayBookDetails() {
        let url = "http://milenabooks.azurewebsites.net/api/books/\(Int((book?.id)!))"
        
        self.bookDetailsView.titleLabel.text = book?.title ?? "No title."
        self.bookDetailsView.authorNameLabel.text = book?.author ?? "No author."
        self.bookDetailsView.priceLabel.text = "Price: $\(Double((book?.price ?? 0.0)!))"
        self.bookDetailsView.ratingLabel.text = "Rating: \(Int((book?.rating ?? 0)!))"
        
        if book?.description != nil {
            self.bookDetailsView.descriptionTextView.text = book?.description
        } else {
            Alamofire.request(url)
                .responseObject {(response: DataResponse<Book>) in
                    let bookResponse = response.result.value
                    self.bookDetailsView.descriptionTextView.text = bookResponse?.description ?? "No description."
            }
        }
        
        if let coverImage = self.book?.coverImage {
            self.bookDetailsView.bookCoverImageView.image = UIImage(data: Data(coverImage))
        } else {
            DispatchQueue.global(qos: .background).async {
                if let url = URL(string: url), let urlContents = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.bookDetailsView.bookCoverImageView.image = UIImage(data: urlContents)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.bookDetailsView.bookCoverImageView.image = UIImage(named: "noimage")
                        self.bookDetailsView.bookCoverImageIndicator.isHidden = true
                    }
                }
            }
        }
    }
    
    private func getBookDetailsById() {
        let url = "http://milenabooks.azurewebsites.net/api/books/\(bookId!)"
        
        Alamofire.request(url)
            .responseObject {(response: DataResponse<Book>) in
                let bookResponse = response.result.value
                
                self.bookDetailsView.titleLabel.text = bookResponse?.title
                self.bookDetailsView.authorNameLabel.text = bookResponse?.author
                self.bookDetailsView.priceLabel.text = "Price: $\(Double((bookResponse?.price)!))"
                self.bookDetailsView.ratingLabel.text = "Rating: \(Int((bookResponse?.rating)!))"
                self.bookDetailsView.descriptionTextView.text = bookResponse?.description ?? "No description."
                
                DispatchQueue.global(qos: .background).async {
                    if let url = bookResponse?.coverImageUrl {
                        
                        let urlContents: Data?
                        
                        if url.isEmpty {
                            urlContents = UIImage(named: "noimage")?.pngData()
                        } else {
                            urlContents = try? Data(contentsOf: (URL(string: url))!)
                        }
                        
                        DispatchQueue.main.async {
                            if let imgData = urlContents {
                                self.bookDetailsView.bookCoverImageView.image = UIImage(data: imgData)
                            } else {
                                self.bookDetailsView.bookCoverImageView.image = UIImage(named: "noimage")
                            }
                            
                            self.bookDetailsView.bookCoverImageIndicator.isHidden = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.bookDetailsView.bookCoverImageView.image = UIImage(named: "noimage")
                            self.bookDetailsView.bookCoverImageIndicator.isHidden = true
                        }
                    }
                }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditBookDetailsSegue" {
            if let destination = segue.destination as? EditBookViewController {
                destination.bookToEdit = book
            }
        }
    }

}
