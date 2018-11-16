//
//  ViewController.swift
//  Telerik-Tasks
//
//  Created by Plamen on 13.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnClick(_ sender: UIButton) {
        let n = 13
        let input = "4114234412493"
        var numbers = [Int:Int]()
        
        for i in input.indices {
            let number = Int(String(input[i]))!
            
            if !numbers.keys.contains(number) {
                numbers[number] = 1
            } else {
                numbers[number] = numbers[number]! + 1
            }
        }
        let max = numbers.max { a, b in a.value < b.value }
        print(max)
    }
    
}

