//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Plamen Atanasov on 21.11.19.
//  Copyright © 2019 Plamen Atanasov. All rights reserved.
//

import SwiftUI

let testData = AnimalType.allCases.map { Animal(type: $0) }.shuffled()

struct ContentView: View {
    var animals: [Animal] = []
    
    var body: some View {
        TabView {
            NavigationView {
                List(testData) { animal in
                    AnimalCell(animal: animal)
                }
                .navigationBarTitle("Animals")
            }
            .tabItem {
                Image(systemName: "1.circle")
                Text("List")
            }.tag(0)
            Text("Second View")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Second")
            }.tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(animals: testData)
    }
}

struct AnimalCell: View {
    let animal: Animal
    var body: some View {
        HStack {
            Image(animal.imageName)
                .resizable()
                .frame(width: 50.0, height: 50.0)
                .cornerRadius(/*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading) {
                Text(animal.name)
                    .font(.headline)
                Text(animal.name)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.trailing, 20)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}
