//
//  CustomButton.swift
//  SwiftUITest
//
//  Created by Plamen Atanasov on 27.11.19.
//  Copyright © 2019 Plamen Atanasov. All rights reserved.
//

import SwiftUI

class CustomButton {
    let id = UUID()
    let title: String
    @State var isTapped = false
    
    init(title: String) {
        self.title = title
    }
    
    func action() {
        isTapped.toggle()
        print("\(title) tapped!")
    }
}
