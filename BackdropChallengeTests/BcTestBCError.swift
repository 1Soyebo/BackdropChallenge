//
//  BcTestBCError.swift
//  BackdropChallengeTests
//
//  Created by Ibukunoluwa Soyebo on 29/10/2022.
//

import XCTest
@testable import BackdropChallenge

final class BcTestBCError: XCTestCase {
    
    var sut: BcError!
    private let apiErrorDescription = "Failed to fetch data, check internet connection"

    override func setUpWithError() throws {
        sut = BcError.apiError
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApiError() throws {
        XCTAssertEqual(sut.localizedDescription, apiErrorDescription)
    }
    
    func testErrorInfoKey() throws{
        let errorDescription = sut.errorUserInfo[NSLocalizedDescriptionKey] as? String ?? ""
        XCTAssertEqual(errorDescription, self.apiErrorDescription)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
