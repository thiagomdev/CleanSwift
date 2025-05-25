//
//  NetworkingMock.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 25/05/25.
//

@testable import CleanArchitecture
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
