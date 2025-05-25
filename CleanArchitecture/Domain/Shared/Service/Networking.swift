//
//  Networking.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

protocol Networking {
    func fetchCep(_ data: String) async throws -> Cep?
}

final class Network {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
}

extension Network: Networking {
    func fetchCep(_ data: String) async throws -> Cep? {
        guard let endpoint = URL(string: "https://viacep.com.br/ws/\(data)/json/") else { return nil }
        let (data, _) = try await session.data(from: endpoint)
        return try JSONDecoder().decode(Cep.self, from: data)
    }
}
