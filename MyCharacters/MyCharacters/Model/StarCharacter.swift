//
//  StarCharacter.swift
//  MyCharacters
//
//  Created by Khateeb H. on 12/15/21.
//

import Foundation

struct StarCharacter: Codable {
    let name: String
    let height: String
    let mass: String
    let hairColor: CharacterColor
    let skinColor: CharacterColor
    let eyeColor: CharacterColor
    let birthYear: String
    let gender: Gender
    let image: URL
}
