//
//  CodeCoverageTests.swift
//  CodeCoverageTests
//
//  Created by Chris Grant on 26/06/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import XCTest

class CodeCoverageTests: XCTestCase {
    
    func testEqualOneCharacterStrings() {
        XCTAssert(checkWord("1", isAnagramOfWord: "1"))
    }
    
    func testDifferentLengthStrings() {
        XCTAssertFalse(checkWord("a", isAnagramOfWord: "bb"))
    }
    
    func testEmptyStrings() {
        XCTAssert(checkWord("", isAnagramOfWord: ""))
    }
    
    func testLongAnagram() {
        XCTAssert(checkWord("chris grant", isAnagramOfWord: "char string"))
    }
    
    func testLongInvalidAnagramWithEqualLengths() {
        XCTAssertFalse(checkWord("apple", isAnagramOfWord: "tests"))
    }
}
