//
//  DiscoveryViewModel.swift
//  Foody
//
//  Created by halil yılmaz on 29.06.2023.
//

import Foundation


class DiscoveryViewModel {
    var didUpdate: ((User?)-> Void)?


    func fetchUserProfil() {
        
        AuthService.shared.fetchUser { user, error in
            if let error = error {
                print(error.localizedDescription)
            } else if var currentUser = user {
                DispatchQueue.main.async {
                    self.didUpdate?(currentUser)
                }
            }
        }
    }

}
