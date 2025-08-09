//
//  MainInteractor.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Foundation
import Combine

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
        let publisher = try await worker.get(cep: data)
        for try await response in publisher.values {
            let cep = CepRequestModel.Response(cep: response)
            try await presenter.present(response: cep)
        }
    }
}
