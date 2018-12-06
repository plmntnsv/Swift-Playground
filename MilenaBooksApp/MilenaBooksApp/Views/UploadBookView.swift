//
//  UploadBookView.swift
//  MilenaBooksApp
//
//  Created by Plamen on 27.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class UploadBookView: UIView {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var coverImageUrlTextField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
        {
        didSet {
            descriptionTextView.layer.cornerRadius = 5
            descriptionTextView.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            descriptionTextView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var displayCoverImageView: BookCoverImageView! {
        didSet {
            displayCoverImageView.image = UIImage(named: "noimageselected")
            displayCoverImageView.addDashedBorder()
        }
    }
    @IBOutlet weak var selectPhotoButton: ActivityButtonView!
}
