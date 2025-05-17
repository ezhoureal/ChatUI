//
//  playgroundUITests.swift
//  playgroundUITests
//
//  Created by Tianer Zhou on 2025/4/22.
//

import XCTest

final class playgroundUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.activate()
        app.windows["Chat"].buttons["new chat button"].click()
        app/*@START_MENU_TOKEN@*/.staticTexts["Ask me anything. Use Shift + Enter for new line"]/*[[".groups.staticTexts[\"Ask me anything. Use Shift + Enter for new line\"]",".staticTexts[\"Ask me anything. Use Shift + Enter for new line\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.click()
        app.typeText("H\r")
        let submitButton = app.buttons["Send"]
        XCTAssertFalse(submitButton.isEnabled, "button isn't disabled after submission")

        // test if submission is blocked while waiting for response
        app.typeText("Hello\r")
        let response = app.staticTexts["this is a mocked response"]
        XCTAssertTrue(response.waitForExistence(timeout: 3), "Text did not appear within 3 seconds")
        XCTAssertTrue(submitButton.isEnabled)
        submitButton.click()
        
        let secondQuery = app.staticTexts["Hello"]
        XCTAssertTrue(secondQuery.exists, "second submission failed")
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
