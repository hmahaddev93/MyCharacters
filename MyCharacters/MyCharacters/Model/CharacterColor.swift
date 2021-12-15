//
//  HairColor.swift
//  MyCharacters
//
//  Created by Khateeb H. on 12/15/21.
//

import Foundation

enum CharacterColor: String {
    case none,
         blond,
         brown,
         black,
         fair,
         gold,
         white,
         light,
         green,
         blue,
         yellow,
         red,
         orange,
         whiteBlue = "white, blue",
         whiteRed = "white, red",
         brownGrey = "brown, grey",
         auburnWhite = "auburn, white",
         greenTanBrown = "green-tan, brown",
         blueGray = "blue-gray",
         unknown
}

extension CharacterColor: Codable {
    public init(from decoder: Decoder) throws {
        self = try CharacterColor(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}
