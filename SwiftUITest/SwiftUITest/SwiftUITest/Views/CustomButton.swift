//
//  CustomButton.swift
//  SwiftUITest
//
//  Created by Plamen Atanasov on 27.11.19.
//  Copyright © 2019 Plamen Atanasov. All rights reserved.
//

import SwiftUI

struct CustomButton: View {
    let id = UUID()
    let title: String
    @Binding var buttonTapped: UUID
    
    var body: some View {
        Button(action: action) {
            Spacer()
            Text(title).foregroundColor(.black)
            Spacer()
        }
         .background(buttonTapped == id ? Color.white : Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
    }
    
    func action() {
        buttonTapped = id
    }
}
