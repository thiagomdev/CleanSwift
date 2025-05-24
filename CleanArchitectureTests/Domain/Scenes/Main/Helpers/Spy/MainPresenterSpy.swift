//
//  MainPresenterSpy.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

@testable import CleanArchitecture
final class MainPresenterSpy: MainPresenting {
    var expectedResponse: CepRequestModel.Response?
    private(set) var presentCalled: Bool = false
    private(set) var presentCount: Int = 0
    
    func present(response: CepRequestModel.Response) async throws {
        presentCalled = true
        presentCount += 1
        expectedResponse = response
    }
}
