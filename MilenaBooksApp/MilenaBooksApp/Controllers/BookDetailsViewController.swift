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
    private lazy var url = ApiEndPoints.BookEndPoint.get(book: book!).fullUrl
    var book: Book?
    
    @IBOutlet weak var bookDetailsView: BookDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayBookDetails()
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        
    }
    
    private func displayBookDetails() {
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
                    self.book?.description = bookResponse?.description
            }
        }
        
        if let coverImage = self.book?.coverImage {
            self.bookDetailsView.bookCoverImageView.image = UIImage(data: Data(coverImage))
        } else {
            self.bookDetailsView.bookCoverImageView.showLoading()
            DispatchQueue.global(qos: .background).async {
                if let url = self.book?.coverImageUrl, let urlOfImg = URL(string: url), let urlContents = try? Data(contentsOf: urlOfImg) {
                    DispatchQueue.main.async {
                        self.bookDetailsView.bookCoverImageView.image = UIImage(data: urlContents)
                        self.bookDetailsView.bookCoverImageView.hideLoading()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.bookDetailsView.bookCoverImageView.image = UIImage(named: "noimage")
                        self.bookDetailsView.bookCoverImageView.hideLoading()
                    }
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsToEditUploadSegue" {
            if let destination = segue.destination as? UploadBookViewController {
                destination.book = book
            }
        }
    }

}
