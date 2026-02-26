//
//  MainViewControllerUITests.swift
//  CleanArchitectureUITests
//
//  Created by Thiago Monteiro on 2/25/26.
//

import XCTest

final class MainViewControllerUITests: XCTestCase {
    
    func test_MainViewController_WhenViewLoadedUIElements_AreEnable() {
        let inputedTextField = makeElements().inputedTextField
        let searchButton = makeElements().searchButton
        
        XCTAssertTrue(inputedTextField.isEnabled)
        XCTAssertTrue(searchButton.isEnabled)
    }
    
    func test_MainViewController_WhenTappedInvalidCep_ShouldAppear_ErrorAlert() {
        let application = makeApp()
        let inputedTextField = makeElements().inputedTextField
        inputedTextField.tap()
        inputedTextField.typeText("011500111111")
        
        let searchButton = makeElements().searchButton
        
        searchButton.tap()
        
        XCTAssertTrue(application.alerts["errorAlertDialog"].waitForExistence(timeout: 1.0))
    }
}

extension MainViewControllerUITests {
    private func makeApp() -> XCUIApplication {
        let application = XCUIApplication()
        application.launch()
        continueAfterFailure = false
        return application
    }
}

extension MainViewControllerUITests {
    private func makeElements() -> (inputedTextField: XCUIElement, searchButton: XCUIElement) {
        let inputedTextField = XCUIApplication().textFields["inputedCepTextField"]
        let searchButton = XCUIApplication().buttons["searchCepButton"]
        return (inputedTextField, searchButton)
    }
}
