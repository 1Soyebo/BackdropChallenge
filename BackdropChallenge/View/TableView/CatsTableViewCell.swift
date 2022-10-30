//
//  CatsTableViewCell.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 27/10/2022.
//

import UIKit

class CatsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCatImage: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lblCatName: UILabel!
    
    static let identifier = "CatsTableViewCell"
    static let cellHeight: CGFloat = 65
    static func getNib() -> UINib{
        return .init(nibName: identifier, bundle: nil)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        lblCatImage.layer.cornerRadius = 10
        lblCatImage.layer.masksToBounds = true
        selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblCatImage.image = .init(named: .catPlaceholderImage)
        lblCatImage.cancelImageLoad()
    }
    
    func bindCatBreedToCell(breed: CatBreed){
        if let imageData = breed.image {
            DispatchQueue.main.async {[weak self] in
                self?.lblCatImage.loadImage(at: imageData.formedUrl)
            }
        }
        lblCatName.text = breed.name?.capitalized
        btnLike.setImage(.init(named: breed._isSelected ? .favouriteeOn:.favouriteOff), for: .normal)
    }
}
