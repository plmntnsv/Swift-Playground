//
//  BookDetailsView.swift
//  MilenaBooksApp
//
//  Created by Plamen on 26.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class BookDetailsView: UIView {
    
    @IBOutlet weak var bookCoverImageIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
        {
        didSet {
            descriptionTextView.isEditable = false
        }
    }
}
