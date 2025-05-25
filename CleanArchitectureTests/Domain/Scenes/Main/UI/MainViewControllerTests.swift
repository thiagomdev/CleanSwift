//
//  MainViewControllerTests.swift
//  CleanArchitectureTests
//
//  Created by Thiago Monteiro on 25/05/25.
//

import Testing
@testable import CleanArchitecture

@Suite("MainViewController", .serialized)
@MainActor
final class MainViewControllerTests {

    @Test(arguments: [("01150011")])
    func display_cep_data(cep: String) async throws {
        let (sut, interactorySpy) = makeSut()
        
        try await sut.displayCepData(.init(cep: .fixture(cep: cep)))
        
        #expect(interactorySpy.loadCalled == false)
        #expect(interactorySpy.loadCount == 0)
        #expect(interactorySpy.expectedData != cep)
    }
}

extension MainViewControllerTests {
    private func makeSut() -> (sut: MainViewController, interactorySpy: MainInteractorSpy) {
        let interactorySpy = MainInteractorSpy()
        let sut = MainViewController(interactor: interactorySpy)
        return (sut, interactorySpy)
    }
}

final class MainInteractorSpy: MainInteracting {
    private(set) var loadCalled: Bool = false
    private(set) var loadCount: Int = 0
    private(set) var expectedData: String?
    
    func load(data: String) async throws {
        loadCalled = true
        loadCount += 1
        expectedData = data
    }
}
