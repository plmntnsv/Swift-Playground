//
//  EditBookViewController.swift
//  MilenaBooksApp
//
//  Created by Plamen on 28.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit
import Alamofire

class EditBookViewController: UIViewController {
    @IBOutlet var editBookView: EditBookView!
    
    var bookToEdit: Book?
    var receivedBook: Book?
    
    private var validBook: Bool {
        get {
            if (editBookView.titleTextField.text?.isEmpty)! {
                (editBookView.editButton)?.hideLoading()
                return false
            }
            
            if (editBookView.authorTextField.text?.isEmpty)! {
                (editBookView.editButton)?.hideLoading()
                return false
            }
            
            if (editBookView.priceTextField.text?.isEmpty)! || Double((editBookView.priceTextField.text)!) == nil {
                (editBookView.editButton)?.hideLoading()
                return false
            }
            
            if (editBookView.ratingTextField.text?.isEmpty)! || Int((editBookView.priceTextField.text)!) == nil {
                (editBookView.editButton)?.hideLoading()
                return false
            }
            
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editBookView.titleTextField.text = bookToEdit?.title ?? "No title"
        editBookView.authorTextField.text = bookToEdit?.author ?? "No author"
        editBookView.priceTextField.text = String((bookToEdit?.price ?? 0.0)!)
        editBookView.ratingTextField.text = String((bookToEdit?.rating ?? 0)!)
        editBookView.coverImageUrlTextField.text = bookToEdit?.coverImageUrl
        editBookView.descriptionTextView.text = bookToEdit?.description ?? "No description"
    }
    
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        if let btn = sender as? ActivityButtonView {
            if !btn.isUploading {
                btn.showLoading()
                if validBook {
                    let title = editBookView.titleTextField.text!
                    let author = editBookView.authorTextField.text!
                    let price = Double(editBookView.priceTextField.text!)!
                    let rating = Int(editBookView.ratingTextField.text!)!
                    let url = editBookView.coverImageUrlTextField.text
                    let desc = editBookView.descriptionTextView.text
                    let book = Book(id: bookToEdit?.id, title: title, price: price, author: author, rating: rating, coverImageUrl: url, description: desc)
                    
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
                          method: .put,
                          parameters: book.toJSON(),
                          encoding: JSONEncoding.default)
            .responseObject { (response: DataResponse<Book>) in
                switch response.result {
                case .success:
                    (self.editBookView.editButton)?.hideLoading()
                    self.receivedBook = response.result.value
                    self.performSegue(withIdentifier: "SaveBookSegue", sender: self.editBookView.editButton)
                case .failure(let error):
                    print(error)
                }
        }
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveBookSegue" {
            if let destination = segue.destination as? BookDetailsViewController {
                destination.book = receivedBook
                destination.bookId = receivedBook?.id!
            }
        }
    }

}
