//
//  CatBreedPersisted+CoreDataProperties.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 28/10/2022.
//
//

import Foundation
import CoreData


extension CatBreedPersisted {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatBreedPersisted> {
        return NSFetchRequest<CatBreedPersisted>(entityName: "CatBreedPersisted")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var breedID: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var imageURL: String?

}

extension CatBreedPersisted : Identifiable {

}
