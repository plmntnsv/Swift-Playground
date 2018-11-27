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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadBookBtnClicked(_ sender: Any) {
        if let btn = sender as? ActivityButtonView {
            if !btn.isUploading {
                btn.showLoading()
                uploadBook()
            } else {
                print("currently uploading")
            }
        }
    }
    
    private func uploadBook() {
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
                          parameters: BookMockData.uploadBook.toJSON(),
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print(response)
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
