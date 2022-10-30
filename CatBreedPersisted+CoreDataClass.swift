//
//  CatBreedPersisted+CoreDataClass.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 28/10/2022.
//
//

import Foundation
import CoreData

@objc(CatBreedPersisted)
public class CatBreedPersisted: NSManagedObject {

    func makeCatBreedPersisted(catBreed: CatBreed){
        self.breedName = catBreed.name
        self.breedID = catBreed.id
//        self.id = UUID()
        self.imageURL = catBreed.image?.url
        
    }
}
