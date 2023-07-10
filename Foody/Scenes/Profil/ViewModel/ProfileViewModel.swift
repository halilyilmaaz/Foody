//
//  ProfileViewModel.swift
//  Foody
//
//  Created by halil yılmaz on 28.06.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ProfileViewModel {
    
    let db = Firestore.firestore()
    var title: String?
    var didUpdateUser: ((User?) -> Void)?
    let profileService = ProfileService.shared
    
    var recipes: [HomeRecipeCardModel] = []
    
    var didUpdateRecipies: (([HomeRecipeCardModel]?, Error?) -> Void)?
    
    
    func fetchUserProfil() {
        AuthService.shared.fetchUser { user, error in
            if let error = error {
                print(error.localizedDescription)
            } else if var currentUser = user {
                currentUser.username = self.title ?? "kullanıcı adı"
                DispatchQueue.main.async {
                    self.didUpdateUser?(user)
                }
            }
        }
    }
    
    
    func fetchRecipe() {
        profileService.fetchRecipeList { [weak self] recipes, error in
            if let error = error {
                self?.didUpdateRecipies?(nil, error)
            } else if let recipes = recipes {
                self?.recipes = recipes
                self?.didUpdateRecipies?(recipes, nil)
            }
        }
    }
}
