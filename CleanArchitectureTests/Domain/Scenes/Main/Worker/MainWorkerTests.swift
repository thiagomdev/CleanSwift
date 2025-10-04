//
//  MainWorkerTests.swift
//  CleanArchitectureTests
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Testing
import Combine
@testable import CleanArchitecture

@Suite(.serialized)
final class MainWorkerTests: LeakTrackerSuite {

    @Test(arguments: [("01150011")])
    func get(cep: String) async throws {
        let (sut, networkingMock) = makeSut()
        networkingMock.expectedCep = .fixture(cep: cep)
        
        let publisher = try await sut.get(cep: cep)
        let result = try await publisher.firstValue()
        
        let expectedCep = try #require(networkingMock.expectedCep)
        #expect(expectedCep == result)
        
        #expect(networkingMock.getCalled == true)
        #expect(networkingMock.getCount == 1)
        #expect(networkingMock.expectedCep == expectedCep)
        #expect(networkingMock.expectedStringCep == cep)
    }
}

extension MainWorkerTests {
    private
    func makeSut(source: SourceLocation = #_sourceLocation) -> (sut: MainWorker, networkingMock: NetworkingMock) {
        let networkingMock = NetworkingMock()
        let sut = MainWorker(networking: networkingMock)
        
        track(sut, source: source)
        track(networkingMock, source: source)

        return (sut, networkingMock)
    }
}

extension Publisher {
    func firstValue() async throws -> Output {
        for try await value in self.values { return value }
        throw CancellationError()
    }
}
