//
//  ActivityIndicator.swift
//  SwiftUITest
//
//  Created by Plamen Atanasov on 2.01.20.
//  Copyright © 2020 Plamen Atanasov. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let v = UIActivityIndicatorView()
        
        return v
    }
    
    func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
        activityIndicator.startAnimating()
    }
}
