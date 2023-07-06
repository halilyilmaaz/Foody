//
//  SearchService.swift
//  Foody
//
//  Created by halil yılmaz on 5.07.2023.
//

import Foundation
import FirebaseFirestore

class SearchService {
    
//    func searchRecipes(withKeyword keyword: String, completion: @escaping ([RecipeCardModel]) -> Void) {
//        let db = Firestore.firestore()
//        
//        // 'recipes' koleksiyonunda 'title' alanına göre sorgu yapılıyor
//        db.collection("recipes")
//            .whereField("title", isGreaterThanOrEqualTo: keyword)
//            .whereField("title", isLessThanOrEqualTo: keyword + "\u{f8ff}")
//            .getDocuments { (querySnapshot, error) in
//                if let error = error {
//                    print("Error searching recipes: \(error)")
//                    completion([])
//                    return
//                }
//                
//                var recipes: [Recipe] = []
//                
//                for document in querySnapshot!.documents {
//                    let recipeData = document.data()
//                    
//                    // Belgeden gerekli verileri alarak Recipe nesnesi oluşturulabilir
//                    let title = recipeData["title"] as? String ?? ""
//                    let description = recipeData["description"] as? String ?? ""
//                    // Diğer verileri de gerektiği gibi alabilirsiniz
//                    
//                    let recipe = RecipeCardModel(title: title, description: description)
//                    recipes.append(recipe)
//                }
//                
//                completion(recipes)
//            }
//    }

   
    
}
