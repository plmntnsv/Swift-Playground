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
                    let book = UploadBook(title: title, price: price, author: author, rating: rating, coverImageUrl: url, description: desc)
                    
                    upload(bookToUpload: book)
                }
            } else {
                print("currently uploading")
            }
        }
    }
    
    private func upload(bookToUpload book: UploadBook) {
        let urlString = "http://milenabooks.azurewebsites.net/api/books"
        //                let headers: HTTPHeaders = [
        //                    "Content-Type": "application/x-www-form-urlencoded",
        //                    "cache-control": "no-cache"
        //                ]
        //
        //                Alamofire.request(urlString,
        //                                  method: .post,
        //                                  parameters: BookMockData.book,
        //                                  encoding: URLEncoding.default,
        //                                  headers: headers)
        //                    .response { response in
        //                            print(response)
        //                        }
        
        Alamofire.request(urlString,
                          method: .post,
                          parameters: book.toJSON(),
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print(response)
                    (self.uploadBookView.uploadButton as? ActivityButtonView)?.hideLoading()
                case .failure(let error):
                    print(error)
                }
                
                
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
