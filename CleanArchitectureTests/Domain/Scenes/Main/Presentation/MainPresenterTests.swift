//
//  MainPresenterTests.swift
//  CleanArchitectureTests
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Testing
@testable import CleanArchitecture

@Suite("MainPresenter", .serialized)
final class MainPresenterTests {
    
    private(set) var sutTracker: MemoryLeakTracker<MainPresenter>?
    private(set) var viewControllerSpyTracker: MemoryLeakTracker<MainViewControllerSpy>?
    
    @Test(arguments: [("01150011")])
    func present(cep: String) async throws {
        let (sut, viewControllerSpy) = makeSut()

        try await sut.present(response: .init(cep: .fixture(cep: cep)))
        
        let viewModel = try #require(viewControllerSpy.expectedDisplayCepData)
        #expect(viewModel != nil)
        #expect(viewModel.cep.cep == cep)
        #expect(viewControllerSpy.displayCepDataCalled == true)
        #expect(viewControllerSpy.displayCepDataCount == 1)
        #expect(viewControllerSpy.expectedDisplayCepData?.cep.cep == cep)
    }
    
    deinit {
        sutTracker?.verify()
        viewControllerSpyTracker?.verify()
    }
}

extension MainPresenterTests {
    private func makeSut(file: String = #file, line: Int = #line, column: Int = #column) -> (sut: MainPresenter, viewControllerSpy: MainViewControllerSpy) {
        let viewControllerSpy = MainViewControllerSpy()
        let sut = MainPresenter()
        sut.viewController = viewControllerSpy
        
        let sourceLocation = SourceLocation(fileID: #fileID, filePath: file, line: line, column: column)
        sutTracker = .init(instance: sut, sourceLocation: sourceLocation)
        viewControllerSpyTracker = .init(instance: viewControllerSpy, sourceLocation: sourceLocation)
        
        return (sut, viewControllerSpy)
    }
}
