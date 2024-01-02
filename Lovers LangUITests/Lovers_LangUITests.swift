//
//  Lovers_LangUITests.swift
//  Lovers LangUITests
//
//  Created by Taylor Carr on 12/28/23.
//

import XCTest

final class Lovers_LangUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-StartFromCleanState", "YES"]
        app.launch()
        
        let langChart = app.otherElements["languagesChart"]

        if(app.buttons["takeQuizButton"].isHittable) {
            app.buttons["takeQuizButton"].tap()
            for _ in 0..<30 {
                app.buttons["buttonA"].tap()
                app.buttons["submit"].tap()
            }
            XCTAssert(langChart.exists)
        } else {
            XCTAssert(langChart.exists)
        }
    }

    func cleanSlate() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.launchArguments = ["-StartFromCleanState", "YES"]
        
        let langChart = app.otherElements["languagesChart"]

        if(app.buttons["takeQuizButton"].isHittable) {
            app.buttons["takeQuizButton"].tap()
            for _ in 0..<30 {
                app.buttons["buttonA"].tap()
                app.buttons["submit"].tap()
            }
        } else {
            XCTAssert(langChart.exists)
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
