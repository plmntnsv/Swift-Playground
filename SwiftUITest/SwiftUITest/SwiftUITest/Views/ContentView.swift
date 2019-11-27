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

struct AnimalCell: View {
    let animal: Animal
    @State private var presentInfo: Bool = false
    
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
            Image(systemName: "arrow.up.circle")
                .foregroundColor(.gray)
                .padding(.trailing, 20)
            
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.presentInfo = true
        }
        .sheet(isPresented: self.$presentInfo, onDismiss: updateUI) {
            AnimalDetails(showModal: self.$presentInfo, animal: self.animal)
        }
        .background(presentInfo ? Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)) : Color.clear)
    }
    
    private func updateUI() {
        presentInfo = false
    }
}
