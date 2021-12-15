//
//  ContentView.swift
//  MyCharacters
//
//  Created by Khateeb H. on 12/15/21.
//

import SwiftUI
import CoreData

struct ListingsView: View {

    @ObservedObject var viewModel:ListingsViewModel = ListingsViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.characters, id: \.name) { item in
                    NavigationLink {
                        Text(item.name)
                    } label: {
                        Text(item.name)
                    }
                }
            }
            .onAppear(perform: {
                viewModel.fetchCharacters()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
//                ToolbarItem {
//                    Button(action: ) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
            }
            Text("Select an item")
        }
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

