//
//  Gender.swift
//  MyCharacters
//
//  Created by Khateeb H. on 12/15/21.
//

import Foundation

enum Gender: String {
    case male,
         female,
         unknown
}

extension Gender: Codable {
    public init(from decoder: Decoder) throws {
        self = try Gender(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}

