//
//  JavaPopUITests.swift
//  JavaPopUITests
//
//  Created by Caio Cezar Lopes dos Santos on 4/5/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import XCTest

class JavaPopUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSelectRxJavaAndGoBackToList() {
        let app = XCUIApplication()
        app.tables.staticTexts["RxJava"].tap()
        app.navigationBars["RxJava"].buttons["Icon Back"].tap()
    }
    
    func testSelectRetrofitAndOpenFirstPullRequestOnBrowser() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["retrofit"].tap()
        tablesQuery.staticTexts["Allowing skipping of query params if the conveters converted to a null"].tap()
    }
    
    func testEndlessScroll() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
        tablesQuery.element.swipeUp()
    }
    
}
