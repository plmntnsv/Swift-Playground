//
//  StartScreenSetGameViewController.swift
//  CardGames
//
//  Created by Plamen on 15.11.18.
//  Copyright © 2018 Plamen. All rights reserved.
//

import UIKit

class StartScreenSetGameViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Start New Set Game" {
            print("segueing")
        }
    }
}
