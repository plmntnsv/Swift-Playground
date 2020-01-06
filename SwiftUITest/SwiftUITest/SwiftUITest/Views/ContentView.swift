//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Plamen Atanasov on 21.11.19.
//  Copyright © 2019 Plamen Atanasov. All rights reserved.
//

import SwiftUI

let allAnimals = AnimalType.allCases.map { Animal(type: $0) }

struct ContentView: View {
    var animals: [Animal] = []
    @State var animalData = allAnimals
    
    init(animals: [Animal]) {
        self.animals = animals
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        UINavigationBar.appearance().barTintColor = .white

        // To remove all separators including the actual ones:
        //UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        TabView {
            NavigationView {
                List {
                    ForEach(animalData, id: \.id) { animal in
                        AnimalCell(animal: animal)
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)
                }
                .navigationBarTitle("Animals")
                .navigationBarItems(trailing: EditButton())
            }
            .tabItem {
                Image(systemName: "ant.fill")
                Text("List")
            }.tag(0)
            
            SegmentControlView()
            .tabItem {
                    Image(systemName: "bandage.fill")
                    Text("Stuff")
            }.tag(1)
            
            NavigationView {
                List {
                    NavigationLink(destination: ActivityIndicator()) {
                        Text("Activity Indicator")
                    }
                    NavigationLink(destination: HomeViewRepresentable()) {
                        Text("TableView From Storyboard")
                    }
                }
            }
            .tabItem {
                Image(systemName: "wand.and.rays")
                Text("UIKit+SwiftUI")
            }.tag(2)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        animalData.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(at offsets: IndexSet) {
        animalData.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(animals: allAnimals)
    }
}
