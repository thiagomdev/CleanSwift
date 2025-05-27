//
//  MainViewControllerSpy.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 25/05/25.
//

@testable import CleanArchitecture
final class MainViewControllerSpy: MainViewControllerDisplayableLogic {
    var expectedDisplayCepData: CepRequestModel.ViewModel?
    
    private(set) var displayCepDataCalled: Bool = false
    private(set) var displayCepDataCount: Int = 0
    
    private(set) var requestCepDataCalled: Bool = false
    private(set) var requestCepDataCount: Int = 0
    private(set) var expectedCep: String?
    
    func displayCepData(_ viewModel: CepRequestModel.ViewModel) async throws {
        displayCepDataCalled = true
        displayCepDataCount += 1
        expectedDisplayCepData = viewModel
    }
    
    func requestCepData(_ cep: String) async throws {
        requestCepDataCalled = true
        requestCepDataCount += 1
        expectedCep = cep
    }
}
