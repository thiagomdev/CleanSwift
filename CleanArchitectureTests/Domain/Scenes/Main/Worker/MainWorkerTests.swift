//
//  MainWorkerTests.swift
//  CleanArchitectureTests
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Testing
@testable import CleanArchitecture

@Suite("MainPresenter", .serialized)
final class MainWorkerTests {

    @Test(arguments: [("01150011")])
    func get(cep: String) async throws {
        let (sut, networkingMock) = makeSut()
        networkingMock.expectedCep = .fixture(cep: cep)
        
        let result = try await sut.get(cep: cep)
        
        let expectedCep = try #require(networkingMock.expectedCep)
        #expect(expectedCep != nil)
        #expect(expectedCep == result)
        
        #expect(networkingMock.getCalled == true)
        #expect(networkingMock.getCount == 1)
        #expect(networkingMock.expectedCep == expectedCep)
        #expect(networkingMock.expectedStringCep == cep)
    }
}

final class NetworkingMock: Networking {
 
    var expectedCep: Cep?
    private(set) var getCalled: Bool = false
    private(set) var getCount: Int = 0
    private(set) var expectedStringCep: String?
    
    func fetchCep(_ data: String) async throws -> Cep? {
        getCalled = true
        getCount += 1
        expectedStringCep = data
        return expectedCep
    }
}

extension MainWorkerTests {
    private func makeSut() -> (sut: MainWorker, networkingMock: NetworkingMock) {
        let networkingMock = NetworkingMock()
        let sut = MainWorker(networking: networkingMock)
        return (sut, networkingMock)
    }
}
