//
//  ImageViewExtensions.swift
//  MilenaBooksApp
//
//  Created by Plamen on 29.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImageFromUrl(urlString: String) {
        (self as? BookCoverImageView)?.showLoading()
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlString), let urlContents = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: urlContents)
                    (self as? BookCoverImageView)?.hideLoading()
                }
            } else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "noimage")
                    (self as? BookCoverImageView)?.hideLoading()
                }
            }
        }
    }
}
