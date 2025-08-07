//
//  MainPresenterTests.swift
//  CleanArchitectureTests
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Testing
@testable import CleanArchitecture

@Suite(.serialized)
final class MainPresenterTests: LeakTrackerSuite {

    @Test(arguments: [("01150011")])
    func present(cep: String) async throws {
        let (sut, viewControllerSpy) = makeSut()

        try await sut.present(response: .init(cep: .fixture(cep: cep)))
        
        let viewModel = try #require(viewControllerSpy.expectedDisplayCepData)
        #expect(viewModel.cep.cep == cep)
        #expect(viewControllerSpy.displayCepDataCalled == true)
        #expect(viewControllerSpy.displayCepDataCount == 1)
        #expect(viewControllerSpy.expectedDisplayCepData?.cep.cep == cep)
    }
}

extension MainPresenterTests {
    private
    func makeSut(source: SourceLocation = #_sourceLocation) -> (sut: MainPresenter, viewControllerSpy: MainViewControllerSpy) {
        let viewControllerSpy = MainViewControllerSpy()
        let sut = MainPresenter()
        sut.viewController = viewControllerSpy
        
        track(sut, source: source)
        track(viewControllerSpy, source: source)

        return (sut, viewControllerSpy)
    }
}
