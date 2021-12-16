//
//  ListingsViewModel.swift
//  MyCharacters
//
//  Created by Khateeb H. on 12/15/21.
//

import Foundation


final class ListingsViewModel: ObservableObject {
    @Published var characters:[StarCharacter] = [StarCharacter]()
    private var allCharacters:[StarCharacter] = [StarCharacter]()
        
    func fetchCharacters() {
        if allCharacters.count > 0 { return }
        CharacterService.shared.fetchSampleListing { [unowned self] result in
            switch result {
                
            case .success(let items):
                DispatchQueue.main.async {
                    self.allCharacters = items
                    self.characters = self.allCharacters
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func filterBy(query: String) {
        if !query.isEmpty || query.replacingOccurrences(of: " ", with: "") != "" {
            self.characters = allCharacters.filter{ $0.name.lowercased().contains(query.lowercased())}
        } else {
            self.characters = self.allCharacters
        }
    }
}
