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
    var bookId: Int? {
        didSet {
        }
    }
    @IBOutlet weak var bookDetailsView: BookDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       getBook()
    }
    
    private func getBook() {
        let url = "http://milenabooks.azurewebsites.net/api/books/\(bookId!)"
        
        Alamofire.request(url)
            .responseObject {(response: DataResponse<Book>) in
                let bookResponse = response.result.value
                self.bookDetailsView.titleLabel.text = bookResponse?.title
                self.bookDetailsView.authorNameLabel.text = bookResponse?.author
                self.bookDetailsView.priceLabel.text = "Price: $\(Double((bookResponse?.price)!))"
                self.bookDetailsView.ratingLabel.text = "Rating: \(Int((bookResponse?.rating)!))"
                self.bookDetailsView.descriptionLabel.text = bookResponse?.description ?? "No description."
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
