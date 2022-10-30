//
//  MVObservableObject.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 27/10/2022.
//

import Foundation

final class MVObservableObject<T> {
    
    var value: T {
        didSet {
            DispatchQueue.main.async {[weak self] in
                self?.listener?(self!.value)
            }
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value: T)  {
        self.value = value
    }
    
    func bind(_ listener: @escaping(T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
