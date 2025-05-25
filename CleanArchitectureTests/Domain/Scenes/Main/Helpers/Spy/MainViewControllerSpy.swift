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
    
    func displayCepData(_ viewModel: CepRequestModel.ViewModel) async throws {
        displayCepDataCalled = true
        displayCepDataCount += 1
        expectedDisplayCepData = viewModel
    }
}
