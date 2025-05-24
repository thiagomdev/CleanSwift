//
//  MainInteractor.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Foundation

protocol MainInteracting {
    func load(data: String) async throws
}

final class MainInteractor {
    private let worker: MainWorking
    private let presenter: MainPresenting
    
    init(worker: MainWorking, presenter: MainPresenting) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension MainInteractor: MainInteracting {
    func load(data: String) async throws {
        let response = try await worker.get(cep: data)
        if let response {
            let cep = CepRequestModel.Response(cep: response)
            try await presenter.present(response: cep)
        }
    }
}
