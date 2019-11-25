//
//  AnimalDetails.swift
//  SwiftUITest
//
//  Created by Plamen Atanasov on 21.11.19.
//  Copyright © 2019 Plamen Atanasov. All rights reserved.
//

import SwiftUI

struct AnimalDetails: View {
    let animal: Animal
    var body: some View {
        VStack(alignment: .center) {
            Image(animal.imageName)
                 .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.blue, lineWidth: 4)
                )
                .shadow(radius: 10)
            Text(animal.name)
                .font(.title)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .padding([.top], 25)
    }
}

struct AnimalDetails_Previews: PreviewProvider {
    static var previews: some View {
        AnimalDetails(animal: testData[1])
    }
}
