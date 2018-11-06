//
//  ViewController.swift
//  MyTestApp
//
//  Created by Plamen on 5.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class MyModel {
    var storage = 0
}

var model = MyModel()

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.text = "\(model.storage)"
    }
}
