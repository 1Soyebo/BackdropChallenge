//
//  BaseViewController.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 27/10/2022.
//

import UIKit

class BaseViewController: UIViewController {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var abActivityIndicator: UIActivityIndicatorView = {
        let objectActivityIndicator = UIActivityIndicatorView()
        objectActivityIndicator.color = .blue
        objectActivityIndicator.hidesWhenStopped = true
        return objectActivityIndicator
    }()
    
    init(){
        super.init(nibName: NSStringFromClass(Self.self).components(separatedBy: ".")[1], bundle: nil)
        centerAbActivityIndicatorView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func centerAbActivityIndicatorView(){
        view.addSubview(abActivityIndicator)
        abActivityIndicator.centerInSuperview()
        self.view.bringSubviewToFront(abActivityIndicator)
    }
    
    func handleError(abError: String?){
        if let unwrappedError = abError{
            self.abActivityIndicator.stopAnimating()
            self.showAlert(title: .bcError, message: unwrappedError)
        }
    }
    
    func handleIsLoading(isLoading: Bool?){
        DispatchQueue.main.async {[weak self] in
            (isLoading ?? false) ? self?.abActivityIndicator.startAnimating() : self?.abActivityIndicator.stopAnimating()
        }
    }
}

