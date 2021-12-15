//
//  MyCharactersApp.swift
//  MyCharacters
//
//  Created by Khateeb H. on 12/15/21.
//

import SwiftUI

@main
struct MyCharactersApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ListingsView()
        }
    }
}
