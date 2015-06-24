//
//  UserInterfaceTestingUITests.swift
//  UserInterfaceTestingUITests
//
//  Created by Chris Grant on 23/06/2015.
//  Copyright © 2015 ShinobiControls. All rights reserved.
//

import Foundation
import XCTest

class UserInterfaceTestingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    func testTapViewDetailWhenSwitchIsOffDoesNothing() {
        let app = XCUIApplication()
        
        // Change the switch to off.
        app.switches["View Detail Enabled Switch"].tap()
        
        // Tap the view detail button.
        app.buttons["View Detail"].tap()
        
        // Verify that nothing has happened and we are still at the menu scren.
        XCTAssertEqual(app.navigationBars.element.identifier, "Menu")
    }
    
    func testTapViewDetailWhenSwitchIsOnNavigatesToDetailViewController() {
        let app = XCUIApplication()
        
        // Tap the view detail button.
        app.buttons["View Detail"].tap()
        
        // Verify that navigation occurred and we are at the detail screen.
        XCTAssertEqual(app.navigationBars.element.identifier, "Detail")
    }
    
    func testTapIncrementButtonIncrementsValueLabel() {
        let app = XCUIApplication()
        
        // Tap the view detail button to open the detail page.
        app.buttons["View Detail"].tap()

        // Store the increment value button and the value label as we will use them a lot.
        let incrementButton = app.buttons["Increment Value"]
        let valueLabel = app.staticTexts["Number Value Label"]
        
        for index in 0...10 {
            // Tap the increment value button.
            incrementButton.tap()

            // Ensure that the value has increased by 1.
            XCTAssertEqual(valueLabel.value as! String, "\(index)")
        }
    }
}
