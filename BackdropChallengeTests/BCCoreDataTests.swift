//
//  BCCoreDataTests.swift
//  BackdropChallengeTests
//
//  Created by Ibukunoluwa Soyebo on 29/10/2022.
//

import XCTest
@testable import BackdropChallenge

final class BCCoreDataTests: XCTestCase {
    
    var sut: CoreDataStack!
    var arrayCount: Int!

    override func setUpWithError() throws {
        sut = CoreDataStack(modelName: .catDataStack)
        arrayCount = sut.persistedCats.count
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testInitialState() throws {
        XCTAssertEqual(arrayCount, sut.persistedCats.count, "coreData stack should be empty")
    }

}
