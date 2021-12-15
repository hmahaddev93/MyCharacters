//
//  HttpClient.swift
//  MyCharacters
//
//  Created by Khateeb H. on 12/15/21.
//

import Foundation

final class HttpClient {
    static let shared: HttpClient = HttpClient()

    enum HttpClientError: Error {
        case invalidResponse(Data?, URLResponse?)
    }
    
    public func get(url: URL, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: urlRequest){ data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }

            guard
                let responseData = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    completionBlock(.failure(HttpClientError.invalidResponse(data, response)))
                    return
            }

            completionBlock(.success(responseData))
        }
        .resume()
    }
}
