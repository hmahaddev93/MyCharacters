//
//  ListingsViewModel.swift
//  MyCharacters
//
//  Created by Khateeb H. on 12/15/21.
//

import Foundation


final class ListingsViewModel: ObservableObject {
    @Published var characters:[StarCharacter] = [StarCharacter]()
        
    func fetchCharacters() {
        CharacterService.shared.fetchSampleListing { [unowned self] result in
            switch result {
                
            case .success(let items):
                DispatchQueue.main.async {
                    self.characters = items
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
