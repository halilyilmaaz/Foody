//
//  HomeViewModel.swift
//  Foody
//
//  Created by halil yılmaz on 5.06.2023.
//

import Foundation

class HomeViewModel {
    
    var didSignOut: (() -> Void)?
    var didFetchRecipies: (([HomeRecipeCardModel]?, Error?) -> Void)?
    
    var recipies: [HomeRecipeCardModel] = []
    
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
    
    func fetchHomeRecipe() {
        HomeService.shared.fetchHomeRecipe { recipes, error in
            if let error = error {
                print("Error fetching home recipes: 🚩\(error)")
                
            } else {
                self.recipies = recipes ?? []
                self.didFetchRecipies?(recipes,nil)
            }
        }
    }
}
