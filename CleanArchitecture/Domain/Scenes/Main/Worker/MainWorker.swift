//
//  MainWorker.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Combine
import Foundation

protocol MainWorking {
    func get(cep: String) async throws -> AnyPublisher<Cep, Error>
}

final class MainWorker {
    private let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
}

extension MainWorker: MainWorking {
    func get(cep: String) async throws -> AnyPublisher<Cep, Error> {
        await networking.fetchCep(cep)
    }
}
