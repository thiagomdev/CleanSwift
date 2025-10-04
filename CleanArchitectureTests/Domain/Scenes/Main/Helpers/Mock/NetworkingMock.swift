//
//  NetworkingMock.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 25/05/25.
//
import Combine
import Foundation
@testable import CleanArchitecture

final class NetworkingMock: Networking {
    var expectedCep: Cep?
    
    private(set) var getCalled: Bool = false
    private(set) var getCount: Int = 0
    private(set) var expectedStringCep: String?
    
    func fetchCep(_ cep: String) async -> AnyPublisher<Cep, any Error> {
        getCalled = true
        getCount += 1
        expectedStringCep = cep
        if let cep = expectedCep {
            return Just(cep)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "Mock", code: 1, userInfo: nil))
                .eraseToAnyPublisher()
        }
    }
}
