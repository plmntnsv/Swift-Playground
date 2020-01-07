//
//  TableViewRepresentable.swift
//  SwiftUITest
//
//  Created by Plamen Atanasov on 6.01.20.
//  Copyright © 2020 Plamen Atanasov. All rights reserved.
//

import SwiftUI

struct HomeViewRepresentable: UIViewRepresentable {
    private let cells: [String] = ["Cell 1", "Cell 2", "Cell 3", "Cell 4", "Cell 5"]
    
    func makeUIView(context: Context) -> UIView {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()!.view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        //do your logic here
    }
}
