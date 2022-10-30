//
//  RefreshControl.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 28/10/2022.
//

import UIKit

class BcRefreshControl: UIRefreshControl {
    
    var selectorMethod: (()->())?
    var refreshControlTitle: String = ""{
        didSet{
            let font = UIFont.boldSystemFont(ofSize: 12)
            let color = #colorLiteral(red: 0.02408897504, green: 0.06511634588, blue: 0.3753129244, alpha: 1)
            let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color]
            self.attributedTitle = NSAttributedString(string: refreshControlTitle, attributes: attributes)
        }
    }
    
    
    init(selectorMethod: @escaping (()->()), refreshControlTitle: String){
        super.init()
        self.refreshControlTitle = refreshControlTitle
        self.selectorMethod = selectorMethod
        setupTMRefresh()
    }

    private func setupTMRefresh(){
        self.addTarget(self, action: #selector(performOperations), for: .valueChanged)
    }

    @objc func performOperations(){
        if let selectorMethod = selectorMethod {
            selectorMethod()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTMRefresh()
    }
}
