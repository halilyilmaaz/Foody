//
//  SearchService.swift
//  Foody
//
//  Created by halil yılmaz on 5.07.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class SearchService {
    static let shared = SearchService()
    
    
    func searchRecipes(withKeyword keyword: String, completion: @escaping ([HomeRecipeCardModel]?, Error?) -> Void) {
        let db = Firestore.firestore()
        
        // 'homeRecipies' koleksiyonunda 'title' alanına göre sorgu yapılıyor
        db.collection("homeRecipies")
            .whereField("title", isGreaterThanOrEqualTo: keyword)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error searching recipes: \(error)")
                    completion(nil, error)
                    return
                }
                
                var recipes: [HomeRecipeCardModel] = []
                
                let dispatchGroup = DispatchGroup()
                
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
                    dispatchGroup.enter()
                    // Firebase Storage'dan fotoğrafın indirilmesi
                    self.fetchFoto(photoURL: photoURL) { (image, error) in
                        if let error = error {
                            print("Error downloading image: \(error)")
                        }
                        if let image = image {
                            recipe.photoURL = image.description
                        }
                        // Fotoğraf indirildiğinde DispatchGroup'tan çıkıldı
                        dispatchGroup.leave()
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
    
    func searchRecipesByMaterials(materials: [String], completion: @escaping ([HomeRecipeCardModel]?, Error?) -> Void) {
            let db = Firestore.firestore()
            
        db.collection("homeRecipies")
                .whereField("materials", arrayContainsAny: materials)
                .getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error searching recipes: \(error)")
                        completion(nil, error)
                        return
                    }
                    
                    var recipes: [HomeRecipeCardModel] = []
                    
                    let dispatchGroup = DispatchGroup()
                    
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
                        dispatchGroup.enter()
                        // Firebase Storage'dan fotoğrafın indirilmesi
                        self.fetchFoto(photoURL: photoURL) { (image, error) in
                            if let error = error {
                                print("Error downloading image: \(error)")
                            }
                            if let image = image {
                                recipe.photoURL = image.description
                            }
                            // Fotoğraf indirildiğinde DispatchGroup'tan çıkıldı
                            dispatchGroup.leave()
                        }
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        completion(recipes, nil)
                    }
                }
        }
}
