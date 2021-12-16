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
    @State private var query: String = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $query, onTextChanged: viewModel.filterBy(query:))
                List {
                    ForEach(viewModel.characters, id: \.name) { character in
                        NavigationLink {
                            CharacterDetailView(character: character)
                        } label: {
                            HStack {
                                ImageView(url: character.image, width: 80, height: 80)
                                    .cornerRadius(4)
                                    .offset(x: 0, y: 0)
                                    
                                Text(character.name)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onAppear(perform: {
                viewModel.fetchCharacters()
            })
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

