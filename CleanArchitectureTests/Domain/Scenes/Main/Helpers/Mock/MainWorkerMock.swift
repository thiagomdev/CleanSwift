//
//  MainWorkerMock.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

@testable import CleanArchitecture
final class MainWorkerMock: MainWorking {
    var expectedCep: Cep?
    
    private(set) var getCalled: Bool = false
    private(set) var getCount: Int = 0
    private(set) var expectedStringCep: String?
    
    func get(cep: String) async throws -> Cep? {
        getCalled = true
        getCount += 1
        expectedStringCep = cep
        return expectedCep
    }
}
