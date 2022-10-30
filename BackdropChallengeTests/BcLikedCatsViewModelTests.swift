//
//  BcLikedCatsViewModelTests.swift
//  BackdropChallengeTests
//
//  Created by Ibukunoluwa Soyebo on 29/10/2022.
//

import XCTest
@testable import BackdropChallenge

final class BcLikedCatsViewModelTests: XCTestCase {
    
    var sut: LikedViewModel!

    override func setUpWithError() throws {
        sut = LikedViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testPersistedCatCount() throws {
        XCTAssertEqual(sut.arrayPersistedCats.count, AppDelegate.sharedAppDelegate.coreDataStack.persistedCats.count, "persisted cat count in viewmodel should be the same as persisted cats in core data stack")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
    }

}
