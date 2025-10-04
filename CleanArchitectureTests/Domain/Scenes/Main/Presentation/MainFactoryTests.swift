//
//  MainFactoryTests.swift
//  CleanArchitectureTests
//
//  Created by Thiago Monteiro on 30/08/25.
//

import Testing
import UIKit
@testable import CleanArchitecture

@MainActor
struct MainFactoryTests {
    private
    func makeSut() -> UIViewController {
        MainFactory.make()
    }

    @Test
    func test_make_returns_MainViewController() async throws {
        let vc = makeSut()
        #expect(vc is MainViewController)
    }
}
