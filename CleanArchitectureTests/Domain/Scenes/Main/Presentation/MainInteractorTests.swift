//
//  MainInteractorTests.swift
//  CleanArchitectureTests
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Testing
@testable import CleanArchitecture

@Suite("MainInteractor", .serialized)
final class MainInteractorTests {
    
    @Test(arguments: [("01150011")])
    func load_success(cep: String) async throws {
        let (sut, doubles) = makeSut()
        let expected: Cep = .fixture(cep: cep)
        doubles.workerMock.expectedCep = expected
        
        try await sut.load(data: cep)
        
        let response = try #require(doubles.presenterSpy.expectedResponse)
        #expect(response.cep != nil)
        
        #expect(doubles.workerMock.getCalled)
        #expect(doubles.workerMock.getCount == 1)
        #expect(doubles.workerMock.expectedCep?.cep == cep)
        
        #expect(doubles.presenterSpy.presentCalled)
        #expect(doubles.presenterSpy.presentCount == 1)
        #expect(doubles.presenterSpy.expectedResponse?.cep.cep == cep)
    }
}

extension MainInteractorTests {
    private typealias Doubles = (
        workerMock: MainWorkerMock,
        presenterSpy: MainPresenterSpy
    )
    
    private func makeSut() -> (sut: MainInteractor, doubles: Doubles) {
        let workerMock = MainWorkerMock()
        let presenterSpy = MainPresenterSpy()
        let sut = MainInteractor(worker: workerMock, presenter: presenterSpy)
        return (sut, (workerMock, presenterSpy))
    }
}
