//
//  ViewController.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 27/10/2022.
//

import UIKit

class CatsViewController: BaseViewController {
    
    lazy var catsRefreshControl: UIRefreshControl = {
        return BcRefreshControl(selectorMethod: getCatBreeds, refreshControlTitle: "Get 🐈")
    }()
    
    private let viewModel = CatViewModel.shared
    
    @IBOutlet weak var tblCats: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        setupObservers()
        getCatBreeds()
        centerAbActivityIndicatorView()
    }
    
    @objc
    private func getCatBreeds(){
        viewModel.getBreeds()
    }

    private func configureTable(){
        tblCats.dataSource = self
        tblCats.delegate = self
        tblCats.tableFooterView = UIView()
        tblCats.register(CatsTableViewCell.getNib(), forCellReuseIdentifier: CatsTableViewCell.identifier)
        tblCats.separatorStyle = .none
        tblCats.rowHeight = CatsTableViewCell.cellHeight
        tblCats.refreshControl = catsRefreshControl
    }
    
    private func setupObservers(){
        viewModel.getBreedError.bind{[weak self] bcError in
            self?.handleError(abError: bcError)
        }
        
        viewModel.getBreedsPayload.bind{[weak self] _ in
            DispatchQueue.main.async {
                self?.tblCats.reloadData()
            }
        }
        
        viewModel.isLoading.bind{[weak self] isLoading in
            if !(isLoading ?? false){self?.catsRefreshControl.endRefreshing()}
            self?.handleIsLoading(isLoading: isLoading)
        }
    }
}

extension CatsViewController: UITableViewDelegate{}

extension CatsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.preselectedCats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCats.dequeueReusableCell(withIdentifier: CatsTableViewCell.identifier) as! CatsTableViewCell
        cell.btnLike.tag = indexPath.row
        cell.btnLike.addTarget(self, action: #selector(toggleFavourite), for: .touchUpInside)
        cell.bindCatBreedToCell(breed: viewModel.preselectedCats[indexPath.row])
        return cell
    }
    
    @objc
    private func toggleFavourite(_ sender: UIButton!){
        let selectedCatBreed = viewModel.catArray[sender.tag]
        selectedCatBreed.isSelected = !selectedCatBreed._isSelected
        sender.setImage(.init(named: selectedCatBreed._isSelected ? .favouriteeOn:.favouriteOff), for: .normal)
        AppDelegate.sharedAppDelegate.coreDataStack.updateCoreData(with: selectedCatBreed)
    }
}
