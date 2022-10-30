//
//  CoreDataStack.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 28/10/2022.
//

import Foundation
import CoreData

class CoreDataStack {
    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    var persistedCats: [CatBreedPersisted]{
        do{
            return try storeContainer.viewContext.fetch(CatBreedPersisted.fetchRequest())
        }catch(let fetchError as NSError){
            print(fetchError.description)
        }
        return []
    }
    
    func updateCoreData(with catBreed: CatBreed){
        if catBreed._isSelected{
            if let _ = persistedCats.first(where: {$0.breedID == catBreed.id}){ return }
            let catBreedPersisted = CatBreedPersisted(entity: CatBreedPersisted.entity(), insertInto: managedContext)
            catBreedPersisted.makeCatBreedPersisted(catBreed: catBreed)
            saveContext()
        }else{
            if let existingCat = persistedCats.first(where: {$0.breedID == catBreed.id}){
                managedContext.delete(existingCat)
                saveContext()
            }
        }
    }
}
