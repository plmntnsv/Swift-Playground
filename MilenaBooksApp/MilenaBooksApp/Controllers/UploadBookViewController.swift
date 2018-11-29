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
    
    var book: Book?
    private var editVerb: HTTPMethod?
    private var urlString: String?
    
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
            
            if (uploadBookView.ratingTextField.text?.isEmpty)! || Int((uploadBookView.ratingTextField.text)!) == nil {
                (uploadBookView.uploadButton as? ActivityButtonView)?.hideLoading()
                return false
            }
            
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let bookToEdit = book {
            editVerb = .put
            urlString = ApiEndPoints.BookEndPoint.edit(book: book!).fullUrl
            
            uploadBookView.uploadButton.setTitle("Edit", for: .normal)
            uploadBookView.uploadButton.backgroundColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
            uploadBookView.titleTextField.text = bookToEdit.title ?? "No title"
            uploadBookView.authorTextField.text = bookToEdit.author ?? "No author"
            uploadBookView.priceTextField.text = String((bookToEdit.price ?? 0.0)!)
            uploadBookView.ratingTextField.text = String((bookToEdit.rating ?? 0)!)
            uploadBookView.coverImageUrlTextField.text = bookToEdit.coverImageUrl
            uploadBookView.descriptionTextView.text = bookToEdit.description
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
                    
                    book = Book(id: nil, title: title, price: price, author: author, rating: rating, coverImageUrl: url, description: desc)
                    
                    if let editUrl = urlString {
                        post(bookToPost: book!, to: editUrl)
                    } else {
                        post(bookToPost: book!, to: ApiEndPoints.BookEndPoint.post.fullUrl)
                    }
                    
                } else {
                    print("invalid book")
                }
            } else {
                print("currently uploading")
            }
        }
    }
    
    private func post(bookToPost book: Book, to urlString: String) {
        Alamofire.request(urlString,
                          method: self.editVerb ?? .post,
                          parameters: book.toJSON(),
                          encoding: JSONEncoding.default)
            .responseObject { (response: DataResponse<Book>) in
                switch response.result {
                case .success:
                    (self.uploadBookView.uploadButton as? ActivityButtonView)?.hideLoading()
                    self.book = response.result.value
                    self.performSegue(withIdentifier: "EditUploadToDetailsSegue", sender: self.uploadBookView.uploadButton)
                case .failure(let error):
                    (self.uploadBookView.uploadButton as? ActivityButtonView)?.hideLoading()
                    print(error)
                }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditUploadToDetailsSegue" {
            if let destination = segue.destination as? BookDetailsViewController {
                destination.book = book
            }
        }
    }
}
