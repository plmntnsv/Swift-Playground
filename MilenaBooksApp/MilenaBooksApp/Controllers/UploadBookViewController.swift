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
    private var isEdit = false
    
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
            isEdit = true
            
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
                    let id = book?.id
                    let title = uploadBookView.titleTextField.text!
                    let author = uploadBookView.authorTextField.text!
                    let price = Double(uploadBookView.priceTextField.text!)!
                    let rating = Int(uploadBookView.ratingTextField.text!)!
                    let url = uploadBookView.coverImageUrlTextField.text
                    let desc = uploadBookView.descriptionTextView.text
                    
                    book = Book(id: id, title: title, price: price, author: author, rating: rating, coverImageUrl: url, description: desc)
                    
                    if isEdit {
                        post(book!, to: ApiEndPoints.BookEndPoint.edit(book: book!).fullUrl, with: .put)
                    } else {
                        post(book!, to: ApiEndPoints.BookEndPoint.post.fullUrl, with: .post)
                    }
                    
                } else {
                    print("invalid book")
                }
            } else {
                print("currently uploading")
            }
        }
    }
    
    private func post(_ book: Book, to urlString: String, with verb: HTTPMethod) {
        Alamofire.request(urlString,
                          method: verb,
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
