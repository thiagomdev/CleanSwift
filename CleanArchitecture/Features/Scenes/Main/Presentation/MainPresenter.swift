//
//  MainPresenter.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Foundation

protocol MainPresenting {
    func present(response: CepRequestModel.Response) async throws
}

@MainActor
final class MainPresenter {
    weak var viewController: MainViewControllerDisplayableLogic?
}

extension MainPresenter: MainPresenting {
    func present(response: CepRequestModel.Response) async throws {
        let viewModel = CepRequestModel.ViewModel(cep: response.cep)
        try await viewController?.displayCepData(viewModel)
    }
}
