//
//  CatCollectionViewCell.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 27/10/2022.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lblCatName: UILabel!
    @IBOutlet weak var imgCat: UIImageView!
    
    static let identifier = "CatCollectionViewCell"
    static let cellHeight: CGFloat = 196
    static func getNib() -> UINib{
        return .init(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imgCat.layer.cornerRadius = 10
        imgCat.layer.masksToBounds = true
        btnLike.setImage(.init(named:.favouriteeOn), for: .normal)
       
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgCat.image = .init(named: .catPlaceholderImage)
        imgCat.cancelImageLoad()
    }
    
    func bindCatBreedToCell(breed: CatBreedPersisted){
        if let _imageURL = breed.imageURL, let formedURL = URL(string: _imageURL) {
            imgCat.image = .init(named: .catPlaceholderImage)
            self.imgCat.loadImage(at: formedURL)
        }
        lblCatName.text = breed.breedName?.capitalized
    }

}
