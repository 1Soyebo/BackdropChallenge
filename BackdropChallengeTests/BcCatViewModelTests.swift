//
//  BackdropChallengeTests.swift
//  BackdropChallengeTests
//
//  Created by Ibukunoluwa Soyebo on 29/10/2022.
//

import XCTest
@testable import BackdropChallenge

class MockCats{
    static let firstCat = CatBreed(id: "cat", name: "BackDropCat")
}

class MockErrorCatService: CatService{
    func getCatBreeds(completionHandler: @escaping (Result<[BackdropChallenge.CatBreed], BackdropChallenge.BcError>) -> ()) {
        completionHandler(.failure(.session))
    }
    
    var networkManager: BackdropChallenge.NetworkManager = NetworkManager.shared
}

class MockSuccessCatService: CatService{
    func getCatBreeds(completionHandler: @escaping (Result<[BackdropChallenge.CatBreed], BackdropChallenge.BcError>) -> ()) {
        completionHandler(.success([MockCats.firstCat]))
    }
    
    var networkManager: BackdropChallenge.NetworkManager = NetworkManager.shared
}

final class BcCatViewModelTests: XCTestCase {

    var sut: CatViewModel!
    
    
    override func setUpWithError() throws {
        sut = CatViewModel(apiService: MockSuccessCatService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testNilValues(){
        XCTAssertNil(sut.getBreedError.value)
        XCTAssertNil(sut.getBreedsPayload.value)
        XCTAssertNil(sut.isLoading.value)
    }
    
    func testCatCount() throws {
        sut.getBreeds()
        XCTAssertEqual(1, sut.catArray.count, "There should be 1 cat in the cat array")
        
    }
    
    func testFavoriteCount(){
        sut.getBreeds()
        XCTAssertEqual(0, sut.favouriteCat.count, "No cats selected")
        sut.catArray.forEach{$0.isSelected = true} // select all cats
        XCTAssertEqual(sut.catArray.count, sut.favouriteCat.count, "Favourite cats and all cats count equal")
    }
    
    func testPreselectedCatCount(){
        XCTAssertEqual(0, sut.preselectedCats.count, "No cats preselected")
    }

    func testErrorNetworkCall() throws {
        sut = CatViewModel(apiService: MockErrorCatService())
        XCTAssertNil(sut.getBreedError.value)
        sut.getBreeds()
        XCTAssertEqual(sut.getBreedError.value, BcError.session.localizedDescription)
    }

}
