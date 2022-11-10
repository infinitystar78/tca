//
//  NetworkService.swift
//  ReduxLikeDemo
//
//  Created by M W on 09/11/2022.
//

import Foundation
import Combine

class NetworkService {
    
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    func searchPublisher(matching query: String) -> AnyPublisher<[Recipe], Error> {
        
        guard
            var urlComponents = URLComponents(string: "https://api")
            else { preconditionFailure("Can't create url components...") }

        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]

        guard
            let url = urlComponents.url
            else { preconditionFailure("Can't create url from url components...") }
        
        
        return session
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Recipe.self, decoder: decoder)
            .map { $0.items }
            .eraseToAnyPublisher()
    }
    
    
}
