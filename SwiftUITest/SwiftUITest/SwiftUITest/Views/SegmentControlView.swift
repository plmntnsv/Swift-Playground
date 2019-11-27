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
    
    private var buttons = [
            CustomButton(title: "Button1"),
            CustomButton(title: "Button2"),
            CustomButton(title: "Button3")
        ]
    
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
                ForEach(buttons, id: \.id) { btn in
                    Button(action: {
                        self.buttons.forEach {
                            $0.isTapped = false
                        }
                        
                        btn.action()
                    }) {
                        Spacer()
                        Text(btn.title)
                            .foregroundColor(.black)
                        Spacer()
                    }.background(btn.isTapped ? Color.white : Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                }
            }
            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            Spacer()
        }.padding()
    }
    
    private func button1Action() {
        
    }
}

struct SegmentControlView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentControlView()
    }
}
