//
//  HomeViewModel.swift
//  Foody
//
//  Created by halil yılmaz on 5.06.2023.
//

import Foundation

class HomeViewModel {
    
    var didSignOut: (() -> Void)?
    
    func logOut(){
        AuthService.shared.logOut { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.didSignOut?()
                print("başarılı")
            }
            
        }
    }
}
