//
//  BookCoverImageView.swift
//  MilenaBooksApp
//
//  Created by Plamen on 29.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class BookCoverImageView: UIImageView {
    private let shapeLayer:CAShapeLayer = CAShapeLayer()
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

extension BookCoverImageView {
    func addDashedBorder() {
        let color = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1).cgColor
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        self.shapeLayer.bounds = shapeRect
        self.shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.strokeColor = color
        self.shapeLayer.lineWidth = 2
        self.shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        self.shapeLayer.lineDashPattern = [6,3]
        self.shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func removeBorder(){
        self.shapeLayer.removeFromSuperlayer()
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
    }
}
