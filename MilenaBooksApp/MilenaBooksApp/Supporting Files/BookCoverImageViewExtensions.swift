//
//  ImageViewExtensions.swift
//  MilenaBooksApp
//
//  Created by Plamen on 29.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation
import UIKit

extension BookCoverImageView {
    func downloadImageFromUrl(urlString: String, completion: @escaping (_ data: Data?) -> ()) {
        self.showLoading()
        
        DispatchQueue.global(qos: .background).async {
            var resultData: Data?
            
            if let url = URL(string: urlString), let urlContents = try? Data(contentsOf: url) {
                resultData = urlContents
            } else {
                resultData = UIImage(named: "noimage")?.pngData()
            }
            
            DispatchQueue.main.async {
                if let resultData = resultData {
                    completion(resultData)
                    self.image = UIImage(data: resultData)
                }
                
                self.hideLoading()
            }
        }
    }
}
