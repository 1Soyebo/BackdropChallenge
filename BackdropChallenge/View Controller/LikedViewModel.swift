//
//  LikedViewModel.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 28/10/2022.
//

import Foundation

final class LikedViewModel{
    var arrayPersistedCats: [CatBreedPersisted] {
        return AppDelegate.sharedAppDelegate.coreDataStack.persistedCats
    }
    
}
