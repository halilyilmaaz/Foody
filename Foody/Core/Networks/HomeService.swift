//
//  HomeService.swift
//  Foody
//
//  Created by halil yılmaz on 7.07.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class HomeService {
    static let shared = HomeService()
    private let db = Firestore.firestore()
    
    func fetchHomeRecipe(completion: @escaping ([HomeRecipeCardModel]?, Error?) -> Void) {
        let collectionRef = db.collection("homeRecipies")
        
        collectionRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            var recipes: [HomeRecipeCardModel] = []
            let dispatchGroup = DispatchGroup() // DispatchGroup kullanarak işlemleri senkronize ediyoruz
            
            for document in querySnapshot!.documents {
                let recipeData = document.data()
                
                let title = recipeData["title"] as? String ?? ""
                let subTitle = recipeData["subTitle"] as? String ?? ""
                let recipeTime = recipeData["recipeTime"] as? Int ?? 0
                let photoURL = recipeData["photoURL"] as? String ?? ""
                let materials = recipeData["materials"] as? [String] ?? []
                let howManyPersonFor = recipeData["howManyPersonFor"] as? Int ?? 0
                
                var recipe = HomeRecipeCardModel(title: title, description: subTitle, recipeTime: recipeTime, photoURL: photoURL, materials: materials, howManyPersonFor: howManyPersonFor)
                recipes.append(recipe)
                
                dispatchGroup.enter() // DispatchGroup'a giriyoruz
                
                // Fotoğrafın indirilmesi
                self.fetchFoto(photoURL: photoURL) { (image, error) in
                    if let error = error {
                        print("Error downloading image: \(error)")
                    }
                    if let image = image {
                        recipe.photoURL = image.description
                    }
                    
                    dispatchGroup.leave() // DispatchGroup'tan çıkıyoruz
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(recipes, nil)
            }
        }
    }

    
    
    func fetchFoto(photoURL: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let storageRef = Storage.storage().reference().child(photoURL)
        storageRef.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
            if let error = error {
                completion(nil, error)
            } else if let data = data, let image = UIImage(data: data) {
                completion(image, nil)
            } else {
                completion(nil, FetchError.invalidData)
            }
        }
    }
}
