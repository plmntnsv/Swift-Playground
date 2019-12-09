//
//  SegmentControlView.swift
//  SwiftUITest
//
//  Created by Plamen Atanasov on 27.11.19.
//  Copyright © 2019 Plamen Atanasov. All rights reserved.
//

import SwiftUI

struct SegmentControlView: View {
    @State private var selectorIndex = 0
    @State private var numbers = ["One","Two","Three"]
    @State private var buttonTapped = UUID()
    
    private var buttonsData = ["Button 1", "Button 2", "Button 3"]
    private var buttons: [CustomButton] = []
    
    var body: some View {
        VStack {
            Picker("Numbers", selection: $selectorIndex) {
                ForEach(0 ..< numbers.count) { index in
                    Text(self.numbers[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Text("Selected value is: \(numbers[selectorIndex])").padding()
            
            Divider()
            
            HStack(spacing: 1) {
                ForEach(0..<buttonsData.count) { index in
                    CustomButton(title: self.buttonsData[index],
                        buttonTapped: self.$buttonTapped)
                }
            }
            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            Spacer()
        }.padding()
    }
}

struct SegmentControlView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentControlView()
    }
}
