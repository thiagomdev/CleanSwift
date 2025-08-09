//
//  Networking.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Combine
import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

protocol Networking {
    func fetchCep(_ cep: String) async -> AnyPublisher<Cep, Error>
}

final class Network {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
}

extension Network: Networking {
    func fetchCep(_ cep: String) async -> AnyPublisher<Cep, Error> {
        guard let url = URL(string: "https://viacep.com.br/ws/\(cep)/json/") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Cep.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
