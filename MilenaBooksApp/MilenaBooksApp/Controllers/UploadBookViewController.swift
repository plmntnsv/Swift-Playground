//
//  UploadBookViewController.swift
//  MilenaBooksApp
//
//  Created by Plamen on 27.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit
import Alamofire

class UploadBookViewController: UIViewController {
    @IBOutlet var uploadBookView: UploadBookView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadBook(_ sender: Any) {
        if let btn = sender as? ActivityButtonView {
            if !btn.isUploading {
                btn.showLoading()
                
                let urlString = "http://milenabooks.azurewebsites.net/api/upload"
                
                Alamofire.request(urlString, method: .post, parameters: ["foo": "bar"], encoding: JSONEncoding.default, headers: nil).responseJSON {
                    response in
                    switch response.result {
                    case .success:
                        print(response)
                        
                        break
                    case .failure(let error):
                        
                        print(error)
                    }
                }
            } else {
                btn.hideLoading()
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
