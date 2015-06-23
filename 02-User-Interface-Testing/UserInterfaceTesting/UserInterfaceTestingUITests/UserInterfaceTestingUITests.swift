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
    
    func testExample() {
        
    }
    
}
