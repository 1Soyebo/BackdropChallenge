//
//  CatViewModel.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 27/10/2022.
//

import Foundation

final class CatViewModel{
    
    static let shared = CatViewModel()
    
    var getBreedsPayload: MVObservableObject<[CatBreed]?> = MVObservableObject(nil)
    var getBreedError: MVObservableObject<String?> = MVObservableObject(nil)
    var isLoading: MVObservableObject<Bool?> = MVObservableObject(nil)

    var catArray: [CatBreed]{
        return getBreedsPayload.value ?? []
    }
    
    var preselectedCats: [CatBreed]{
        let preselected = catArray
        AppDelegate.sharedAppDelegate.coreDataStack.persistedCats.forEach{likedCat in
            preselected.first(where: {$0.id == likedCat.breedID})?.isSelected = true
        }
        return preselected
    }
    
    var favouriteCat: [CatBreed]{
        return catArray.filter(\._isSelected)
    }
    
    private let apiService: CatService
    
    init(apiService: CatService = ApiService.shared){
        self.apiService = apiService
    }
    
    func getBreeds(){
        isLoading.value = true
        apiService.getCatBreeds{[weak self] apiResponse in
            self?.isLoading.value = false
            switch apiResponse{
            case .success(let apiValue):
                self?.getBreedsPayload.value = apiValue
            case .failure(let abError):
                self?.getBreedError.value = abError.localizedDescription
            }
        }
    }
}
