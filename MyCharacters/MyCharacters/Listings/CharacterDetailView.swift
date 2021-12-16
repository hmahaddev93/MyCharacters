//
//  CharacterDetailView.swift
//  MyCharacters
//
//  Created by Khateeb H. on 12/16/21.
//

import SwiftUI

struct CharacterDetailView: View {
    
    let character: StarCharacter
    var body: some View {
            List {
                ImageView(url: character.image)
                    .offset(x: 0, y: 0)
                Text("Birth Year: \(character.birthYear)")
                Text("Gender: \(character.gender.rawValue)")
                Text("Height: \(character.height)")
                Text("Mass: \(character.mass)")
                Text("Eye Color: \(character.eyeColor.rawValue)")
                Text("Hair Color: \(character.hairColor.rawValue)")
                Text("Skin Color: \(character.skinColor.rawValue)")
            }
            .listStyle(.plain)
            .navigationTitle(character.name)
    }
}
