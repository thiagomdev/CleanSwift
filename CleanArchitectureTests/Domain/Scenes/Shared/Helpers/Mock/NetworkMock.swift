//
//  NetworkMock.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 25/05/25.
//

import Foundation
@testable import CleanArchitecture

final class NetworkMock: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = mockError { throw error }
        
        let data = mockData ?? Data()
        let response = mockResponse ?? HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        return (data, response)
    }
}
