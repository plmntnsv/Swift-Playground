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
    var book: Book? {
        didSet {
        }
    }
    @IBOutlet weak var bookDetailsView: BookDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       getBookDetails()
    }
    
    private func getBookDetails() {
        let url = "http://milenabooks.azurewebsites.net/api/books/\(Int((book?.id)!))"
        
        Alamofire.request(url)
            .responseObject {(response: DataResponse<Book>) in
                let bookResponse = response.result.value
                self.bookDetailsView.titleLabel.text = self.book?.title
                self.bookDetailsView.authorNameLabel.text = self.book?.author
                self.bookDetailsView.priceLabel.text = "Price: $\(Double((self.book?.price)!))"
                self.bookDetailsView.ratingLabel.text = "Rating: \(Int((self.book?.rating)!))"
                
                self.bookDetailsView.descriptionLabel.text = bookResponse?.description ?? "No description."
                
                self.bookDetailsView.bookCoverImageView.image = UIImage(data: Data((self.book?.coverImage)!))
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
