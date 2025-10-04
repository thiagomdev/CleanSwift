//
//  MainWorkerMock.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Combine
import Foundation
@testable import CleanArchitecture

final class MainWorkerMock: MainWorking {
    var expectedCep: Cep?
    
    private(set) var getCalled: Bool = false
    private(set) var getCount: Int = 0
    private(set) var expectedStringCep: String?
    
    func get(cep: String) async throws -> AnyPublisher<Cep, any Error> {
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
