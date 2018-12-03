//
//  BookCoverImageView.swift
//  MilenaBooksApp
//
//  Created by Plamen on 29.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class BookCoverImageView: UIImageView {
    var imageUrl: String?
    var activityIndicator: UIActivityIndicatorView!
    private(set) var isFetching = false
    
    func showLoading() {
        isFetching = true
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func hideLoading() {
        isFetching = false
        activityIndicator.stopAnimating()
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        activityIndicator.isUserInteractionEnabled = false
        let buttonHeight = self.bounds.size.height
        let buttonWidth = self.bounds.size.width
        activityIndicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
        
        let scale = max(min((self.frame.size.height - 4) / 21, 2.0), 0.0)
        let transform: CGAffineTransform = CGAffineTransform(scaleX: scale, y: scale)
        activityIndicator.transform = transform
        
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }

}

extension BookCoverImageView {
    func downloadImageFromUrl(urlString: String, completion: @escaping (_ data: Data?) -> ()) {
        self.showLoading()
        self.imageUrl = urlString
        
        DispatchQueue.global(qos: .background).async {
            
            var resultData: Data?
            
            if let url = URL(string: urlString), let urlContents = try? Data(contentsOf: url) {
                resultData = urlContents
            } else {
                resultData = UIImage(named: "noimage")?.pngData()
            }
            
            DispatchQueue.main.async {
                if self.imageUrl == urlString {
                    if let resultData = resultData {
                        completion(resultData)
                        //self.image = UIImage(data: resultData)
                    }
                }
                
                self.hideLoading()
            }
        }
    }
}
