//
//  MainPresenterTests.swift
//  CleanArchitectureTests
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Testing
@testable import CleanArchitecture

@Suite("MainPresenter", .serialized)
final class MainPresenterTests {

    @Test(arguments: [("01150011")])
    func present(cep: String) async throws {
        let (sut, viewControllerSpy) = makeSut()

        try await sut.present(response: .init(cep: .fixture(cep: cep)))
        
        let viewModel = try #require(viewControllerSpy.expectedDisplayCepData)
        #expect(viewModel != nil)
        #expect(viewModel.cep.cep == cep)
        #expect(viewControllerSpy.displayCepDataCalled == true)
        #expect(viewControllerSpy.displayCepDataCount == 1)
        #expect(viewControllerSpy.expectedDisplayCepData?.cep.cep == cep)
    }
}

extension MainPresenterTests {
    private func makeSut() -> (sut: MainPresenter, viewControllerSpy: MainViewControllerSpy) {
        let viewControllerSpy = MainViewControllerSpy()
        let sut = MainPresenter()
        sut.viewController = viewControllerSpy
        return (sut, viewControllerSpy)
    }
}

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
