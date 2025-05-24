//
//  Networking.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Foundation

protocol Networking {
    func fetchCep(_ data: String) async throws -> Cep?
}

final class Network {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension Network: Networking {
    func fetchCep(_ data: String) async throws -> Cep? {
        if let endpoint = URL(string: "https://viacep.com.br/ws/\(data)/json/") {
            let (data, _) = try await session.data(from: endpoint)
            return try JSONDecoder().decode(Cep.self, from: data)
        }
        return nil
    }
}
