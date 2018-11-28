//
//  UploadBookViewController.swift
//  MilenaBooksApp
//
//  Created by Plamen on 27.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class UploadBookViewController: UIViewController {
    
    @IBOutlet var uploadBookView: UploadBookView!
    
    private var receivedBook: Book?
    // TODO: use SwiftValidator lib
    private var validBook: Bool {
        get {
            if (uploadBookView.titleTextField.text?.isEmpty)! {
                (uploadBookView.uploadButton as? ActivityButtonView)?.hideLoading()
                return false
            }
            
            if (uploadBookView.authorTextField.text?.isEmpty)! {
                (uploadBookView.uploadButton as? ActivityButtonView)?.hideLoading()
                return false
            }
            
            if (uploadBookView.priceTextField.text?.isEmpty)! || Double((uploadBookView.priceTextField.text)!) == nil {
                (uploadBookView.uploadButton as? ActivityButtonView)?.hideLoading()
                return false
            }
            
            if (uploadBookView.ratingTextField.text?.isEmpty)! || Int((uploadBookView.priceTextField.text)!) == nil {
                (uploadBookView.uploadButton as? ActivityButtonView)?.hideLoading()
                return false
            }
            
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if receivedBook?.id != nil {
            uploadBookView.uploadButton.setTitle("Edit", for: .normal)
            uploadBookView.titleTextField.text = receivedBook?.title
            uploadBookView.authorTextField.text = receivedBook?.author
            uploadBookView.priceTextField.text = String((receivedBook?.price)!)
            uploadBookView.ratingTextField.text = String((receivedBook?.rating)!)
            uploadBookView.coverImageUrlTextField.text = receivedBook?.coverImageUrl
            uploadBookView.descriptionTextView.text = receivedBook?.description
        }
    }
    
    @IBAction func uploadBookBtnClicked(_ sender: Any) {
        if let btn = sender as? ActivityButtonView {
            if !btn.isUploading {
                btn.showLoading()
                if validBook {
                    let title = uploadBookView.titleTextField.text!
                    let author = uploadBookView.authorTextField.text!
                    let price = Double(uploadBookView.priceTextField.text!)!
                    let rating = Int(uploadBookView.ratingTextField.text!)!
                    let url = uploadBookView.coverImageUrlTextField.text
                    let desc = uploadBookView.descriptionTextView.text
                    let book = Book(id: nil, title: title, price: price, author: author, rating: rating, coverImageUrl: url, description: desc)
                    
                    upload(bookToUpload: book)
                }
            } else {
                print("currently uploading")
            }
        }
    }
    
    private func upload(bookToUpload book: Book) {
        let urlString = "http://milenabooks.azurewebsites.net/api/books"
        
        Alamofire.request(urlString,
                          method: .post,
                          parameters: book.toJSON(),
                          encoding: JSONEncoding.default)
            .responseObject { (response: DataResponse<Book>) in
                switch response.result {
                case .success:
                    (self.uploadBookView.uploadButton as? ActivityButtonView)?.hideLoading()
                    self.receivedBook = response.result.value
                    self.performSegue(withIdentifier: "UploadToDetailsSegue", sender: self.uploadBookView.uploadButton)
                case .failure(let error):
                    print(error)
                }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UploadToDetailsSegue" {
            if let destination = segue.destination as? BookDetailsViewController {
                destination.book = receivedBook
                destination.bookId = receivedBook?.id!
            }
        }
    }
}
