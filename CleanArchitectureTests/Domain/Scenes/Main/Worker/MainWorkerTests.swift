//
//  MainWorkerTests.swift
//  CleanArchitectureTests
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Testing
@testable import CleanArchitecture

@Suite("MainWorker", .serialized)
final class MainWorkerTests {
    
    private(set) var sutTracker: MemoryLeakTracker<MainWorker>?
    private(set) var networkingMockTracker: MemoryLeakTracker<NetworkingMock>?
    
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
    
    deinit {
        sutTracker?.verify()
        networkingMockTracker?.verify()
    }
}

extension MainWorkerTests {
    private func makeSut(file: String = #file, line: Int = #line, column: Int = #column) -> (sut: MainWorker, networkingMock: NetworkingMock) {
        let networkingMock = NetworkingMock()
        let sut = MainWorker(networking: networkingMock)
        
        let sourceLocation = SourceLocation(fileID: #fileID, filePath: file, line: line, column: column)
        sutTracker = .init(instance: sut, sourceLocation: sourceLocation)
        networkingMockTracker = .init(instance: networkingMock, sourceLocation: sourceLocation)
        
        return (sut, networkingMock)
    }
}
