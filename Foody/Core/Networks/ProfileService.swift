//
//  ProfileService.swift
//  Foody
//
//  Created by halil yılmaz on 29.06.2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

enum FetchError: Error {
    case invalidData
}

class ProfileService {
    
    public static let shared = ProfileService()
    private init() {}
    
    let db = Firestore.firestore()
    
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
    
    
    func fetchRecipeList(completion: @escaping ([RecipeCardModel]?, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(nil, nil)
            return
        }
        
        let collectionRef = db.collection("recipies").document(userUID).collection(userUID)
        
        collectionRef.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            var recipes: [RecipeCardModel] = []
            
            let dispatchGroup = DispatchGroup() // DispatchGroup oluşturuldu
            
            for document in querySnapshot!.documents {
                let recipeData = document.data()
                
                let title = recipeData["title"] as? String ?? ""
                let description = recipeData["subTitle"] as? String ?? ""
                let recipeTime = recipeData["recipeTime"] as? Int ?? 5
                let photoURL = recipeData["photoURL"] as? String ?? ""
                let materials = recipeData["materials"] as? [String] ?? []
                let howManyPersonFor = recipeData["howManyPersonFor"] as? Int ?? 1
                
                var recipe = RecipeCardModel(title: title, description: description, recipeTime: recipeTime, photoURL: photoURL, materials: materials, howManyPersonFor: howManyPersonFor)
                
                // Fotoğrafın indirilmesi için DispatchGroup'a girildi
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
                
                recipes.append(recipe)
            }
            
            // Tüm fotoğrafların indirilmesini beklemek için DispatchGroup'un tamamlanması bekleniyor
            dispatchGroup.notify(queue: .main) {
                completion(recipes, nil)
            }
        }
    }

    
    func deleteRecipe(documentID: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(false, nil)
            return
        }
        
        let collectionRef = db.collection("recipies").document(userUID).collection(userUID)
        let recipeRef = collectionRef.document(documentID)
        
        // Belgeyi silmeden önce fotoğrafı Firebase Storage'dan silmek için DispatchGroup oluşturuldu
        let dispatchGroup = DispatchGroup()
        
        recipeRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let recipeData = document.data()
                
                if let photoURL = recipeData?["photoURL"] as? String {
                    let storageRef = Storage.storage().reference().child(photoURL)
                    
                    // Fotoğrafı silmek için DispatchGroup'a girildi
                    dispatchGroup.enter()
                    
                    // Firebase Storage'dan fotoğrafın silinmesi
                    storageRef.delete { error in
                        if let error = error {
                            print("Error deleting image: \(error)")
                        }
                        
                        // Fotoğraf silindiğinde DispatchGroup'tan çıkıldı
                        dispatchGroup.leave()
                    }
                }
            }
            
            // Belgeyi Firestore'dan silme işlemi
            recipeRef.delete { error in
                if let error = error {
                    completion(false, error)
                } else {
                    // Tüm işlemlerin tamamlanmasını beklemek için DispatchGroup'un tamamlanması bekleniyor
                    dispatchGroup.notify(queue: .main) {
                        completion(true, nil)
                    }
                }
            }
        }
    }

}
