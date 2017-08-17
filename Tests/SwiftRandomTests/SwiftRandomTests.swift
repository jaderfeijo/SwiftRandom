//
//  SwiftRandomTests.swift
//  SwiftRandomTests
//
//  Created by Jader Feijo on 17/8/17.
//
//

import XCTest

@testable import SwiftRandom

/// Tests above `SwiftRandom` module.
class SwiftRandomTests: XCTestCase {
    /// Tests if all static methods are working.
    func testStaticMethods() {
        XCTAssertNotNil(Randoms.randomInt(10, 20))
        XCTAssertNotNil(Randoms.randomPercentageisOver(70))
        XCTAssertNotNil(Randoms.randomBool())
        XCTAssertNotNil(Randoms.randomDateWithinDaysBeforeToday(5))
        XCTAssertNotNil(Randoms.randomDate())
        XCTAssertNotNil(Randoms.randomFakeName())
        XCTAssertNotNil(Randoms.randomFakeGender())
        XCTAssertNotNil(Randoms.randomFakeConversation())
        XCTAssertNotNil(Randoms.randomFakeTitle())
        XCTAssertNotNil(Randoms.randomFakeTag())
        XCTAssertNotNil(Randoms.randomFakeNameAndEnglishHonorific())
        XCTAssertNotNil(Randoms.randomNSURL())
    }

    /// Tests for extensions applied directly above Swift types.
    func testTypeExtensions() {
        XCTAssertNotNil(Int.random())
        XCTAssertNotNil(Date.random())
        XCTAssertNotNil(Date.randomWithinDaysBeforeToday(7))
        XCTAssertNotNil(Float.random())
        XCTAssertNotNil(Double.random())
        XCTAssertNotNil(URL.random())
    }

    /// Tests for SwiftRandom when applied above a list.
    func testListItemRandom() {
        let entry = ["hello", "world"]

        for _ in 0...10 {
            XCTAssertNotNil(entry[0..<entry.count].randomItem())
            XCTAssertNotNil(entry.randomItem())
        }
    }

    /// Tests using SwiftRandom above a `Range` of Int.
    func testRandomIntRange() {
        for _ in 0...10 {
            let randomUntilTen = Int.random(0...10)

            XCTAssertGreaterThanOrEqual(randomUntilTen, 0)
            XCTAssertLessThanOrEqual(randomUntilTen, 10)

            let randomLessTen = Int.random(0..<10)

            XCTAssertGreaterThanOrEqual(randomLessTen, 0)
            XCTAssertLessThan(randomLessTen, 10)
        }
    }
	
    /// Tests generating random a `String` of a specified length.
    func testRandomStringOfLength() {
        let precision = 100
        let length = 128
        
        var all: [String] = []
        
        (1...precision).forEach { _ in
            let random: String = .random(ofLength: length)
            XCTAssertEqual(random.characters.count, length)
            
            if all.contains(random) {
                // this is very unlikely to happen with precisions of 100 or over and lengths of 128 or over.
                // if this happens, it is likely a bug in the random string generator.
                XCTFail("Random string collision")
            }
            all.append(random)
        }
        
        XCTAssertEqual(String.random(ofLength: -1), "")
        XCTAssertEqual(String.random(ofLength: 0), "")
    }
    
    /// Tests generating a random `String` of variable length.
    func testRandomStringOfVariableLength() {
        let precision = 100
        let minimumLength = 128
        let maximumLength = 256
        
        var all: [String] = []
        
        (1...precision).forEach { _ in
            let random: String = .random(minimumLength: minimumLength, maximumLength: maximumLength)
            XCTAssertLessThanOrEqual(random.characters.count, maximumLength)
            XCTAssertGreaterThanOrEqual(random.characters.count, minimumLength)
            
            if all.contains(random) {
                // this is very unlikely to happen with precisions of 100 or over and lengths of 128 or over.
                // if this happens, it is likely a bug in the random string generator.
                XCTFail("Random string collision")
            }
            all.append(random)
        }
        
        XCTAssertEqual(String.random(minimumLength: -1, maximumLength: -2), "")
        XCTAssertEqual(String.random(minimumLength: 1, maximumLength: -2), "")
        XCTAssertEqual(String.random(minimumLength: -1, maximumLength: 2), "")
        XCTAssertEqual(String.random(minimumLength: 0, maximumLength: 0), "")
        XCTAssertEqual(String.random(minimumLength: -1, maximumLength: 0), "")
        XCTAssertEqual(String.random(minimumLength: 0, maximumLength: -2), "")
        XCTAssertEqual(String.random(minimumLength: 10, maximumLength: 5), "")
        
        XCTAssertEqual(String.random(minimumLength: 5, maximumLength: 5).characters.count, 5)
    }
    
    /// Tests generating a string with a character set specified
    func testRandomStringWithPossibleCharacters() {
        let precision = 100
        let length = 3
        let allowedCharacters = "ab"
        
        (1...precision).forEach { _ in
            let random: String = .random(withCharactersInString: "ab", ofLength: length)
            for c in random.characters {
                XCTAssertTrue(allowedCharacters.characters.contains(c))
            }
        }
    }
}
