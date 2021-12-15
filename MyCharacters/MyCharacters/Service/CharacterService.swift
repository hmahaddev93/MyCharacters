//
//  CharacterService.swift
//  MyCharacters
//
//  Created by Khateeb H. on 12/15/21.
//

import Foundation

enum CharacterAPI  {
    static let host: String = "duet-public-content.s3.us-east-2.amazonaws.com"
    enum EndPoints {
        static let sampleListing = "/project.json"
    }
}

protocol CharacterService_Protocol {
    func fetchSampleListing(completion: @escaping (Result<[StarCharacter], Error>) -> Void)
}

final class CharacterService: CharacterService_Protocol {
    static let shared: CharacterService = CharacterService()

    private let httpClient: HttpClient
    private let jsonDecoder: JSONDecoder
    
    init(httpClient: HttpClient = HttpClient.shared) {
        self.httpClient = httpClient
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    struct CharactersResponseBody: Codable {
            let results: [StarCharacter]
    }
    
    func fetchSampleListing(completion: @escaping (Result<[StarCharacter], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = CharacterAPI.host
        urlComponents.path = CharacterAPI.EndPoints.sampleListing
        
        httpClient.get(url: urlComponents.url!) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(Result(catching: { try self.jsonDecoder.decode(CharactersResponseBody.self, from: data).results }))
            }
        }
    }
}
