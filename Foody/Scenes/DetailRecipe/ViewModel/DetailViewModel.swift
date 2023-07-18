//
//  DetailViewModel.swift
//  Foody
//
//  Created by halil yılmaz on 16.07.2023.
//


import FirebaseStorage
import Firebase
import FirebaseStorage

class DetailViewModel {
    
    var didDelete: ((Bool, Error?) -> Void)?
    
    func deleteRecipe(recipeID: UUID) {
        // Firestore referansını alın
        let db = Firestore.firestore()
        
        // Silmek istediğiniz belge yolunu belirleyin (örneğin, "recipes" koleksiyonu altında)
        let collectionReference = db.collection("recipes") // Değişiklik: "recipies" -> "recipes"
        let documentReference = collectionReference.document("\(recipeID)")
        
        // Belgeyi silme işlemini gerçekleştirin
        documentReference.delete { error in
            if let error = error {
                // Hata oluştuysa
                self.didDelete?(false, error)
            } else {
                // Belge başarıyla silindi
                self.deleteHomeRecipe(recipeID: recipeID.uuidString) { success, error in
                    self.didDelete?(success, error)
                }
            }
        }
    }
    
    func deleteHomeRecipe(recipeID: String, completion: @escaping (Bool, Error?) -> Void) {
        let collectionRef = Firestore.firestore().collection("homeRecipies")
        let documentRef = collectionRef.document(recipeID)
        
        documentRef.delete { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }

    
    func deleteRecipePhoto(photoURL: String, completion: @escaping (Bool, Error?) -> Void) {
        // Storage referansını alın
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        // URL'den fotoğrafın adını çıkarın
        let photoName = String(photoURL.split(separator: "/").last ?? "")
        
        // Fotoğrafın olduğu yolun referansını oluşturun
        let photoRef = storageRef.child("recipePhotos").child(photoName)
        
        // Fotoğrafı silme işlemini gerçekleştirin
        photoRef.delete { error in
            if let error = error {
                // Hata oluştuysa
                completion(false, error)
            } else {
                // Fotoğraf başarıyla silindi
                completion(true, nil)
            }
        }
    }
}
