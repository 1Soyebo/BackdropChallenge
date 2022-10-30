//
//  BreedModel.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 27/10/2022.
//

import Foundation

class CatBreed: Decodable{
    internal init(id: String? = nil, name: String? = nil, image: BreedImage? = nil, isSelected: Bool? = false) {
        self.id = id
        self.name = name
        self.image = image
        self.isSelected = isSelected
    }
    
    let id, name: String?
    let image: BreedImage?
    var isSelected: Bool? = false
    
    var _isSelected: Bool{
        return isSelected ?? false
    }
}

struct BreedImage: Decodable{
    let url: String?
    
    var formedUrl: URL{
        return URL(string: url ?? "")!
    }
}
