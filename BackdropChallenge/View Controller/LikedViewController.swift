//
//  LikedViewController.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 27/10/2022.
//

import UIKit

class LikedViewController: BaseViewController {
    private let viewModel = LikedViewModel()
    @IBOutlet weak var collLikedCats: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collLikedCats.reloadData()
    }
    
    private func configureCollectionView(){
        collLikedCats.dataSource = self
        collLikedCats.delegate = self
        collLikedCats.register(CatCollectionViewCell.getNib(), forCellWithReuseIdentifier: CatCollectionViewCell.identifier)
    }
    
}

extension LikedViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: (collLikedCats.frame.width)/2.08, height: CatCollectionViewCell.cellHeight)
    }
}

extension LikedViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.arrayPersistedCats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collLikedCats.dequeueReusableCell(withReuseIdentifier: CatCollectionViewCell.identifier, for: indexPath) as! CatCollectionViewCell
        cell.bindCatBreedToCell(breed: viewModel.arrayPersistedCats[indexPath.item])
        return cell
    }
}
