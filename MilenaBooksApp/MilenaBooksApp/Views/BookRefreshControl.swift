//
//  BookRefreshControl.swift
//  MilenaBooksApp
//
//  Created by Plamen on 5.12.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class BookRefreshControl: UIRefreshControl {
    let attributes: [NSAttributedString.Key: Any] = [
        .foregroundColor : UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    ]
    
    override init() {
        super.init(frame: UIScreen.main.bounds);
        self.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        self.attributedTitle = NSAttributedString(string: "Getting books...", attributes: attributes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
